# Question 1: Map Accounts to Email Domain Counts

Create a method that takes a List of Accounts and a List of Contacts as parameters. The method should return a `Map<String,Map<String,Integer>>`. The outer keys in the output should be each unique Account Name. The inner keys should be each unique email domain from the Contact email addresses related to the Account from the outer key and the values should be the total number of contacts whose Email matches the domain in the key.

## Requirements

1. Handle `null` or empty inputs
2. Include every Account Name as a key in the output Map even if no Contacts or valid domains were found
3. Exclude records where:
   1. `Contact.email` == `null`
   2. `Contact.email` in invalid format
   3. `Account.name` == `null` or ''

**Note:** *The Account and Contact records are not saved to the database. There is a mock `Id` on the Account records. These `Id`'s are also used on the Contact `AccountId`'s for relating Contacts to Accounts. No need to execute SOQL or DML*

Examples:

```text
Input: accounts = [ { name = Hogwarts, Id = }, { name = Gringotts, Id = } ]
       contacts = [ { email: albus.dumbledore@hogwarts.wiz, AccountId =  }, { email: harry.potter@hogwarts.wiz, AccountId = 001000000000001 }, { email: minerva.mcgonagall@hogwartsschool.edu, AccountId = 001000000000001 }, { email: sybill.trelawney@divination.hogwarts.wiz, AccountId = 001000000000001 }, { email: griphook@gringotts.gob, AccountId =  }, { email: griphook@gringotts.gob, AccountId =  } ]
Output: {
    "Hogwarts" => { "hogwarts.wiz" => 2, "hogwartsschool.edu" => 1, "divination.hogwarts.wiz" => 1 },
    "Gringotts" => { "gringotts.gob" => 1 }
}
Explanation: Hogwarts has 2 Contacts with emails matching the "hogwarts.wiz" domain and 1 Contact for each of the "hogwartsschool.edu" and "divination.hogwarts.wiz" domains.
             Gringotts has 1 Contact matching the "gringotts.gob" domain.

Input: {
    { "name": "Empire" } => [ { "email": "vader@imperial.emp" }, { "email": "palpatine@imp.emp" } ],
    { "name": "Rebel Alliance" } => [ { "email": "leia.organa@alliance.reb" }, { "email": "gial.ackbar@issa.trp" } ],
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
