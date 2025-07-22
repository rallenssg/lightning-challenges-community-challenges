# Question 1: Map Accounts to Email Domain Counts

Create a method that takes a List of Accounts and a List of Contacts as parameters. The method should return a `Map<String,Map<String,Integer>>`. The outer keys in the output should be each unique Account Name. The inner keys should be each unique email domain from the Contact email addresses related to the Account from the outer key and the values should be the total number of contacts whose Email matches the domain in the key.

## Requirements

1. Handle `null` or empty inputs
2. Include every Account Name as a key in the output Map even if no Contacts or valid domains were found
3. Exclude records where:
   1. `Contact.Email` == `null` or ''
   2. `Contact.Email` in invalid format
   3. `Account.Name` == `null` or ''

**Note:** *The Account and Contact records are not saved to the database. There is a mock `Id` on the Account records. These `Id`'s are also used on the Contact `AccountId`'s for relating Contacts to Accounts. No need to execute SOQL or DML*

Examples:

```text
Input: accounts = [ { Name = 'Empire', Id = '001000000000001' }, { Name = 'Rebel Alliance', Id = '001000000000002' }, { Name = 'Jedi Order', Id = '001000000000003' } ]
       contacts = [ { Email = 'vader@imperial.emp', AccountId = '001000000000001' }, { Email = 'palpatine@imperial.emp', AccountId = '001000000000001' }, { Email = 'leia.organa@alliance.reb', AccountId = '001000000000002' }, { Email = 'gial.ackbar@issa.trp', AccountId = '001000000000002' }, { Email = '', AccountId = '001000000000003' }, { Email = 'The Force', AccountId = '001000000000003' } ]
Output: { 
    'Empire' => { 'imperial.emp' => 2 },
    'Rebel Alliance' => { 'alliance.reb' => 1, 'issa.trp' => 1 },
    'Jedi Order' => { }
 }
Explanation: 1. The Empire Account has 2 Contacts matching the "imperial.emp" domain.
             2. The Rebel Alliance Account has 1 Contact matching the "alliance.reb" domain and 1 matching the "issa.trp" domain.
             3. The Jedi Order Account Contacts do not have email addresses. They communicate with The Force.

Input: accounts = [ { Name = 'Empire', Id = '001000000000001' }, { Name = 'Rebel Alliance', Id = '001000000000002' }, { Name = 'Jedi Order', Id = '001000000000003' } ]
       contacts = null
Output: {
    'Empire' => { },
    'Rebel Alliance' => { },
    'Jedi Order' => { }
}
Explanation: Account Names should be outer keys with empty Maps as the inner values when contacts input is null.

Input: accounts = null
       contacts = { }
Output: { }
Explanation: When the accounts input is null an empty Map should be returned.
```

Hints:

1. In the output Map - outer keys are Account Names, inner maps track domain counts.
2. Build a Map for AccountId → Name lookups to avoid nested loops.
3. Check for null lists, null objects, missing or blank fields, and invalid emails.
4. Use String.isBlank(), substringAfter('@'), and Pattern/Matcher for email validation.
5. Process each list once - initialize all Accounts first, then process Contacts in a single pass.

## Author

Richard Allen

## Difficulty

Intermediate
