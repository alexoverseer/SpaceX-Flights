infix operator !!

/** Improving Force-Unwrap Error Messages.
 - Parameter wrapped: Value you expected to be able to unwrap.
 - Parameter failureText: Descriptive error message when unwrapping fails.
 */
func !! <T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let xValue = wrapped { return xValue }
    fatalError("\(failureText()), Function: \(#function), Line: \(#line), Column: \(#column)")
}

/** Improving Force-Unwrap Error Messages when type of wrapped parameter can be inferred.
 - Parameter wrapped: Value you expected to be able to unwrap.
 - Parameter failureText: Descriptive error message when unwrapping fails.
 */
func !! <T>(wrapped: Any?, failureText: @autoclosure () -> String) -> T {
    if let xValue = wrapped as? T { return xValue }
    fatalError("\(failureText()), Function: \(#function), Line: \(#line), Column: \(#column)")
}
