import XCTest

class GenerateScreenshots: XCTestCase {

    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    func testGenerateTabBarScreens() {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Home"].tap()
        snapshot("00Home")
        tabBarsQuery.buttons["Schedule"].tap()
        snapshot("01Schedule")
        tabBarsQuery.buttons["Store"].tap()
        snapshot("02Store")
        tabBarsQuery.buttons["Activity"].tap()
        snapshot("03Activity")
        tabBarsQuery.buttons["Profile"].tap()
        snapshot("04Profile")
        app.buttons["stop 2x"].tap()
    }

}
