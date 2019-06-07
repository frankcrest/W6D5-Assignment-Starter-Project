//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Frank Chen on 2019-06-07.
//  Copyright © 2019 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
  
  override func setUp() {
    let app = XCUIApplication()
    continueAfterFailure = false
    
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testAddMeal() {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    addMeal(mealName: "Burger", numberOfCalories: 300)
  }
  
  func testDeleteMeal(){
    deleteMeal(mealName: "Burger", numberOfCalories: 300)
  }
  
  func testShowMealDetail(){
    showMealDetail(mealName: "LOL", numberOfCalories: 300)
  }
  
  func showMealDetail(mealName:String, numberOfCalories:Int){
    addMeal(mealName: mealName, numberOfCalories: numberOfCalories)
    let app = XCUIApplication()
    app.tables.staticTexts["\(mealName) - \(numberOfCalories)"].tap()
    XCTAssertEqual(app.staticTexts["detailViewControllerLabel"].label,"\(mealName) - \(numberOfCalories)")
    app.navigationBars["Detail"].buttons["Master"].tap()
  }
  
  func testDeleteAllMeals(){
    let app = XCUIApplication()
    let staticCells = app.cells
    print("count\(staticCells.count)")
    if staticCells.count == 0{
      XCTAssert(true)
    }else{
      let cells = staticCells.allElementsBoundByIndex
      for _ in cells{
        let toDelete = app.cells.element(boundBy: 0)
        toDelete.swipeLeft()
        app.tables.buttons["Delete"].tap()
      }
    }
  }
  
  func testAddMealThenDelete(){
    addThenDelete()
  }
  
  func addThenDelete(){
    let app = XCUIApplication()
    app.navigationBars["Master"].buttons["Add"].tap()
    
    let addAMealAlert = app.alerts["Add a Meal"]
    let collectionViewsQuery = addAMealAlert.collectionViews
    collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText("gaga")
    
    let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
    textField.tap()
    textField.typeText("1")
    addAMealAlert.buttons["Ok"].tap()
    app.tables/*@START_MENU_TOKEN@*/.staticTexts["gaga - 1"]/*[[".cells.staticTexts[\"gaga - 1\"]",".staticTexts[\"gaga - 1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    app.navigationBars["Detail"].buttons["Master"].tap()
    
    let staticText = app.tables.staticTexts["gaga - 1"]
    if staticText.exists{
      staticText.swipeLeft()
      app.tables.buttons["Delete"].tap()
    }
  }
  
  func deleteMeal(mealName:String, numberOfCalories:Int){
    testAddMeal()
    let app = XCUIApplication()
    let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
    if staticText.exists {
      staticText.swipeLeft()
      app.tables.buttons["Delete"].tap()
    }
  }
  
  func addMeal(mealName:String, numberOfCalories:Int){
    let app = XCUIApplication()
    app.navigationBars["Master"].buttons["Add"].tap()
    
    let addAMealAlert = app.alerts["Add a Meal"]
    let collectionViewsQuery = addAMealAlert.collectionViews
    collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
    
    let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
    textField.tap()
    textField.typeText("\(numberOfCalories)")
    addAMealAlert.buttons["Ok"].tap()
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      addThenDelete()
    }
  }
  
}
