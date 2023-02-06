#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Log4j to JSON
// @raycast.mode fullOutput

// Optional parameters:
// @raycast.icon 🤖
// @raycast.argument1 { "type": "text", "placeholder": "Input" }
// @raycast.packageName Custom

// Documentation:
// @raycast.description Logging
// @raycast.author Johan West
// @raycast.authorURL johanwest.com

// MaxLoanRequest[applicants=[Applicant[birthYear=1976, maritalStatus=REGISTERED_PARTNER_OR_MARRIED, employmentType=PERMANENT, employer=Axess, employmentRole=Tekniken , qualifiesEmploymentLength=true, monthlyIncome=31000]], existingLoans=null, existingProperties=[], newProperty=SpecificProperty[propertyType=HOUSE, downPayment=1500000, operatingCost=0, municipality=Göteborg, livingSpace=150], household=Household[noOfChildBenefits=2, noOfStudentBenefits=0, allowanceReceived=0, allowanceToPay=0, amortizationStudentDebt=0, otherAssets=0, carCost=CarCost[costOfLeasedCars=0, costOfOwnedCars=0], numberOfCarsOwned=0]]

enum TokenType {
  LEFT_BRACKET,
  RIGHT_BRACKET,
  EQUAL,
  COMMA,
}

const arg = process.argv.slice(2)[0];

console.log("Hello World! Argument1 value: " + process.argv.slice(2)[0]);
