function consumeService(packageName, functionName, fn) {
  const consume = pack => fn(pack.mainModule[functionName]())

  if (atom.packages.isPackageActive(packageName)) {
    consume(atom.packages.getActivePackage(packageName))
  } else {
    const disposable = atom.packages.onDidActivatePackage(pack => {
      if (pack.name === packageName) {
        disposable.dispose()
        consume(pack)
      }
    })
  }
}

consumeService('vim-mode-plus', 'provideVimModePlus', ({ Base }) => {
  const prefix = 'vim-mode-plus-user'

  class ScrollDownFive extends Base.getClass('MiniScrollDown') {
    getCount() {
      return 5
    }
  }

  class ScrollUpFive extends Base.getClass('MiniScrollUp') {
    getCount() {
      return 5
    }
  }

  ScrollDownFive.commandPrefix = prefix
  ScrollUpFive.commandPrefix = prefix

  ScrollDownFive.registerCommand()
  ScrollUpFive.registerCommand()
})
