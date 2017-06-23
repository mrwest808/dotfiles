################################################################################
# Global helpers
################################################################################

getPackageService = (packageName, providerName) ->
  pack = atom.packages.getActivePackage(packageName)
  pack.mainModule[providerName]()

getPackageModule = (packageName) ->
  pack = atom.packages.getActivePackage(packageName)
  pack.mainModule


################################################################################
# Setup extensions
################################################################################

disposable = atom.packages.onDidActivateInitialPackages () ->
  configureTreeView(getPackageModule('tree-view'))
  configureVimModePlus(getPackageService('vim-mode-plus', 'provideVimModePlus'))

  disposable.dispose()


################################################################################
# Module specific helpers
################################################################################

###*
 * tree-view extensions
###
configureTreeView = ({ treeView }) ->
  prefix = 'tree-view-user'
  scope = '.tree-view'

  # Helper: Move selected `entry` n `lines` in `direction`
  move = (entry, lines, direction) ->
    while lines-- and entry
      entry = switch direction
        when 'up'
          treeView.previousEntry(entry)
        else
          treeView.nextEntry(entry)

    treeView.selectEntry(entry)

  # Helper: Scroll tree view n `lines` in `direction`
  scrollTreeView = (lines, direction) ->
    entry = treeView.selectedEntry()
    entryHeight = entry.offsetHeight
    scrollHeight = lines * entryHeight

    if direction is 'up'
      treeView.element.scrollTop -= scrollHeight
    else
      treeView.element.scrollTop += scrollHeight

    { scrollTop, offsetHeight } = treeView.element
    entryPosition = entry.offsetTop
    shouldMove = false

    if direction is 'up'
      threshold = scrollTop + offsetHeight - entryHeight
      shouldMove = entryPosition > threshold
    else
      threshold = scrollTop
      shouldMove = entryPosition < threshold

    if shouldMove
      move(entry, lines, direction)

  # Adds a command to jump to a parent folder while in tree view.
  atom.commands.add scope, "#{prefix}:jump-to-parent-folder", () ->
    parentDirectoryEntry = treeView
      .selectedEntry()
      .parentElement
      .closest('.directory')

    treeView.selectEntry(parentDirectoryEntry)
    treeView.scrollToEntry(parentDirectoryEntry)

  # Adds commands for scrolling the tree view.
  atom.commands.add scope, "#{prefix}:scroll-down-one", () ->
    scrollTreeView(1, 'down')
  atom.commands.add scope, "#{prefix}:scroll-up-one", () ->
    scrollTreeView(1, 'up')
  atom.commands.add scope, "#{prefix}:scroll-down-five", () ->
    scrollTreeView(5, 'down')
  atom.commands.add scope, "#{prefix}:scroll-up-five", () ->
    scrollTreeView(5, 'up')

###*
 * vim-mode-plus extensions
###
configureVimModePlus = ({ Base }) ->
  prefix = 'vim-mode-plus-user'

  ScrollDown = Base.getClass('ScrollDown')
  ScrollUp = Base.getClass('ScrollUp')

  class ScrollDownFive extends ScrollDown
    @commandPrefix: prefix
    @extend()

    getCount: -> 5

  class ScrollUpFive extends ScrollUp
    @commandPrefix: prefix
    @extend()

    getCount: -> 5

  ScrollDownFive.registerCommand()
  ScrollUpFive.registerCommand()
