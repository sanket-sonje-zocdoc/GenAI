# Data Class Documentation Rule

## Rule Description

All data classes must be documented following this standardized format to ensure consistency and
clarity across the codebase.

## Required Format

```
/**
 * Brief one-line description of what this data class represents.
 *
 * More detailed description if needed, explaining the purpose and usage
 * of this data class in the context of the application.
 *
 * @property propertyName Description of what this property represents [type] (include units if applicable)
 * @property propertyName2 Description of what this property represents [type] (include units if applicable)
 * @see RelatedClass Reference to related classes if applicable
 */
data class ClassName(
    @SerializedName("property_name")
    val propertyName: Type,

    @SerializedName("property_name_2")
    val propertyName2: Type
)
```

## Rules Checklist

1. **Summary Line**
    - [ ] Single line describing what the class represents
    - [ ] Written as a noun phrase
    - [ ] Starts with capital letter, ends with period
    - [ ] No "This class is..." or "A class that..." prefixes

2. **Detailed Description (if needed)**
    - [ ] Separated from summary by blank line
    - [ ] Explains purpose and context
    - [ ] Includes any important usage notes
    - [ ] Multiple paragraphs separated by blank lines

3. **Properties**
    - [ ] Every property documented with @property tag
    - [ ] Property descriptions start with capital letter
    - [ ] Units included in square brackets if applicable
    - [ ] Nullability mentioned if property is nullable
    - [ ] Default values mentioned if applicable

4. **References**
    - [ ] Related classes referenced using @see tag
    - [ ] Links to parent/child classes if part of hierarchy

## Examples

### Good Example

```
/**
 * Represents a Pokemon's base statistics.
 *
 * Contains the core attributes that define a Pokemon's battle capabilities
 * and physical characteristics in the game.
 *
 * @property baseStat The base value of this stat [0-255]
 * @property effort The effort value (EV) yield when defeating this Pokemon [0-3]
 * @property statInfo Additional information about the stat type
 * @see StatInfo
 */
data class Stat(
    @SerializedName("base_stat")
    val baseStat: Int,

    @SerializedName("effort")
    val effort: Int,

    @SerializedName("stat")
    val statInfo: StatInfo
)
```

### Bad Example

```
// Missing documentation
data class Stat(
    val baseStat: Int,
    val effort: Int,
    val statInfo: StatInfo
)
```

## Common Mistakes to Avoid

1. Missing summary line
2. Starting summary with "This class..."
3. Omitting property documentation
4. Not mentioning units where applicable
5. Not documenting nullability
6. Inconsistent capitalization and punctuation
7. Missing references to related classes

## Tips

- Keep descriptions concise but complete
- Use consistent terminology throughout the codebase
- Include examples for complex properties if needed
- Document any assumptions or constraints
- Mention any validation rules for properties
