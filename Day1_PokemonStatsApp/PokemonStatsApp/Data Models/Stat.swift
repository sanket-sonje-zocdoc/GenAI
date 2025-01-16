/// Represents a single Pokemon statistic
struct Stat: Codable {

    /// The base value of the stat
    let baseStat: Int

    /// The effort value (EV) associated with the stat
    let effort: Int

    /// Detailed information about the stat type
    let stat: StatInfo
    
    /// Coding keys for JSON decoding/encoding
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}
