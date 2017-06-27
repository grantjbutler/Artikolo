// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - Article AutoEquatable
extension Article: Equatable {}
public func == (lhs: Article, rhs: Article) -> Bool {
    guard lhs.url == rhs.url else { return false }
    return true
}
// MARK: - Tag AutoEquatable
extension Tag: Equatable {}
public func == (lhs: Tag, rhs: Tag) -> Bool {
    guard lhs.name == rhs.name else { return false }
    guard lhs.color == rhs.color else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
