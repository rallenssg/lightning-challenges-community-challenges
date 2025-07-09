# Question 1: Map Accounts to Email Domain Counts

Create a method that takes a `Map<Account,List<Contact>>` as a parameter where the keys are Account records and the values are Lists of Contact records related to the key Account. The method should return a `Map<String,Map<String,Integer>>` with Account Names as the outer keys and a Map of unique Contact email domains pointing to the count of Contacts with matching email domains.

## Requirements

1. Handle `null` or empty inputs
2. Handle emails with subdomains in the domain (i.e. name@*subdomain*.domain.com)
3. Include every Account Name as a key in the output Map even if no Contacts or valid domains were found
4. Ignore Contacts where `email` == `null`

**Note:** *The Account and Contact records are not saved in the database. They are only linked through the input Map. `Id` on both Account & Contact records as well as `AccountId` on Contact records are `null`. No need to execute SOQL or DML*

Examples:

```text
Input: {
    { "name": "Hogwarts" } => [ { "email": "albus.dumbledore@hogwarts.wiz" }, { "email": "harry.potter@hogwarts.wiz" }, { "email": "minerva.mcgonagall@hogwartsschool.edu" }, { "email": "sybill.trelawney@divination.hogwarts.wiz" } ],
    { "name": "Gringotts" } => [ { "email": "griphook@gringotts.gob" } ]
}
Output: {
    "Hogwarts" => { "hogwarts.wiz" => 2, "hogwartsschool.edu" => 1, "divination.hogwarts.wiz" => 1 },
    "Gringotts" => { "gringotts.gob" => 1 }
}
Explanation: Hogwarts has 2 Contacts with emails matching the "hogwarts.wiz" domain and 1 Contact for each of the "hogwartsschool.edu" and "divination.hogwarts.wiz" domains.
             Gringotts has 1 Contact matching the "gringotts.gob" domain.

Input: {
    { "name": "Empire" } => [ { "email": "vader@imperial.emp" }, { "email": "palpatine@imp.emp" } ],
    { "name": "Rebel Alliance" } => [ { "email": "leia.organa@alliance.reb" }, { "email": "gial.ackbar@alliance.reb" } ],
    { "name": "Jedi Order" } => [ { "email": null } ]
}
Output: {
    "Empire" => { "imperial.emp" => 1, "imp.emp" => 1 },
    "Rebel Alliance" => { "alliance.reb" => 2 },
    "Jedi Order" => {}
}
Explanation: The Empire has one Contact each matching the "imperial.emp" and "imp.emp" domains.
             The Rebel Alliance has 2 Contacts for the "alliance.reb" domain.
             The Jedi Order Contacts do not have email addresses. They communicate with The Force

Input: null
Output: null
Explanation: A null input should return null
```

Hints:

1. [Hint 1 - general approach or key concept]
2. [Hint 2 - specific technique or method to use]
3. [Hint 3 - edge cases to consider]
4. [Hint 4 - Apex-specific tips (e.g., String methods, syntax)]
5. [Hint 5 - optimization or best practice tip]

## Author

Richard Allen

## Difficulty

Intermediate
