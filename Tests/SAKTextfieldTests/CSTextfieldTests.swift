import XCTest
@testable import SAKTextfield

final class SAKTextfieldTests: XCTestCase {

    func testUnmask() {
        unMaskComparaison("(1", mask: "(#", toCompare: "1")
        unMaskComparaison("12)", mask: "#)#", toCompare: "12")
        unMaskComparaison("", mask: "", toCompare: "")
        unMaskComparaison("1", mask: "#", toCompare: "1")
        unMaskComparaison("1)", mask: "#)", toCompare: "1")
        unMaskComparaison("(123", mask: "(###", toCompare: "123")
        unMaskComparaison("123.456.789-10", mask: "###.###.###-##", toCompare: "12345678910")
        unMaskComparaison("(11) 91234-5678", mask: "(##) #####-####", toCompare: "11912345678")
        unMaskComparaison("123.456.789", mask: "###.###.###-##", toCompare: "123456789")
        unMaskComparaison("(12) 12345-1234", mask: "(##) #####-####", toCompare: "12123451234")
        unMaskComparaison("1234.567.891231-2345", mask: "###.###.###-##", toCompare: "12345678912312345")
        unMaskComparaison("1234-10", mask: "###-##", toCompare: "123410")
    }

    func testMask() {

        maskComparaison("12345678910", mask: "", toCompare: "")
        maskComparaison("12345678910", mask: "#", toCompare: "1")
        maskComparaison("12345678910", mask: "#)", toCompare: "1)")
        maskComparaison("12345678910", mask: "###", toCompare: "123")
        maskComparaison("12345678910", mask: "###.###.###-##", toCompare: "123.456.789-10")
        maskComparaison("12345678910", mask: "(##) #####-####", toCompare: "(12) 34567-8910")
        maskComparaison("123456789", mask: "###.###.###-##", toCompare: "123.456.789")
        maskComparaison("1234567891012345678", mask: "(##) #####-####", toCompare: "(12) 34567-8910")

    }

    func unMaskComparaison(_ string: String, mask: String, toCompare: String) {
        let unmasked = string.unmask(mask: mask)
        XCTAssert(unmasked == toCompare, "\(unmasked) == \(toCompare)")
    }


    func maskComparaison(_ string: String, mask: String, toCompare: String) {
        let masked = string.apply(mask: mask)
        XCTAssert(masked == toCompare, "\(masked) == \(toCompare)")
    }

    static var allTests = [
        ("testMask", testMask),
        ("testUnmask", testUnmask),
    ]
}
