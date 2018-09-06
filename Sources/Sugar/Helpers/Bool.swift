extension Bool {
    init(from string: String) {
        self = ["1", "true"].contains(string.lowercased())
    }
}
