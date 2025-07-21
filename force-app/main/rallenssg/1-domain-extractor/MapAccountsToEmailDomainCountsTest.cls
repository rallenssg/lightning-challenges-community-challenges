@isTest
public with sharing class MapAccountsToEmailDomainCountsTest {
    
    @isTest
    static void testNullOrEmptyAccounts() {
        // Arrange
        List<Contact> contacts = new List<Contact>();
        Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>();
        
        // Act & Assert - Null accounts
        Map<String, Map<String, Integer>> nullResult = 
            MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(null, contacts);
        Assert.areEqual(expected, nullResult, 
            'Empty Map should be returned when accounts input is null');
        
        // Act & Assert - Empty accounts
        Map<String, Map<String, Integer>> emptyResult = 
            MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(new List<Account>(), contacts);
        Assert.areEqual(expected, emptyResult, 
            'Empty Map should be returned when accounts input is empty');
    }
    
    @isTest
    static void testNullOrEmptyContacts() {
        // Arrange
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Empire', Id = '001000000000001'),
            new Account(Name = 'Rebel Alliance', Id = '001000000000002'),
            new Account(Name = 'Jedi Order', Id = '001000000000003')
        };
        Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>{
            'Empire' => new Map<String, Integer>(),
            'Rebel Alliance' => new Map<String, Integer>(),
            'Jedi Order' => new Map<String, Integer>()
        };
        
        // Act & Assert - Null contacts
        Map<String, Map<String, Integer>> nullResult = 
            MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(accounts, null);
        Assert.areEqual(expected, nullResult, 
            'Account Names should be outer keys with empty inner Maps when contacts input is null');
        
        // Act & Assert - Empty contacts
        Map<String, Map<String, Integer>> emptyResult = 
            MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(accounts, new List<Contact>());
        Assert.areEqual(expected, emptyResult, 
            'Account Names should be outer keys with empty inner Maps when contacts input is empty');
    }
    
    @isTest
    static void testInvalidAccounts() {
        // Arrange
        Account nullAccount;
        List<Account> accounts = new List<Account>{
            nullAccount,                                       // null Account
            new Account(Name = '', Id = '001000000000001'),   // blank Name Account
            new Account(Id = '001000000000002'),              // null Name Account
            new Account(Name = 'Test 2')                      // null Id Account
        };
        List<Contact> contacts = new List<Contact>();
        Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>();
        
        // Act
        Map<String, Map<String, Integer>> result = 
            MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(accounts, contacts);
        
        // Assert
        Assert.areEqual(expected, result, 
            'Expected empty Map for invalid Accounts');
    }
    
    @isTest
    static void testInvalidContactsAndEmails() {
        // Arrange
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Empire', Id = '001000000000001'),
            new Account(Name = 'Rebel Alliance', Id = '001000000000002'),
            new Account(Name = 'Jedi Order', Id = '001000000000003')
        };
        
        Contact nullContact;
        List<Contact> contacts = new List<Contact>{
            nullContact,                                                                    // null Contact
            new Contact(AccountId = '001000000000001'), // null Email Contact
            new Contact(AccountId = '001000000000002', Email = ''), // Empty Email Contact
            new Contact(Email = 'test@fake.com'), // null AccountId Contact
            new Contact(AccountId = '001000000000004', Email = 'test@fake.com'), // Invalid AccountId Contact
            new Contact(AccountId = '001000000000001', Email = 'test@test@fake.com'), // multiple @ symbols
            new Contact(AccountId = '001000000000001', Email = 'test@fake.c'), // single character TLD
            new Contact(AccountId = '001000000000001', Email = '@fake.com'), // no username
            new Contact(AccountId = '001000000000002', Email = 't est@fake.com'), // space in email
            new Contact(AccountId = '001000000000002', Email = 'test@'), // no domain
            new Contact(AccountId = '001000000000003', Email = 'testatfake.com'), // no @ symbol
            new Contact(AccountId = '001000000000003', Email = 'test@fakecom'), // no TLD
            new Contact(AccountId = '001000000000003', Email = 'test#$%@fakecom') // invalid characters
        };
        
        Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>{
            'Empire' => new Map<String, Integer>(),
            'Rebel Alliance' => new Map<String, Integer>(),
            'Jedi Order' => new Map<String, Integer>()
        };
        
        // Act
        Map<String, Map<String, Integer>> result = 
            MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(accounts, contacts);
        
        // Assert
        Assert.areEqual(expected, result, 
            'Expected output Map to have Account Names as outer keys and empty inner maps as values when Contacts are invalid');
    }
    
    @isTest
    static void testValidScenarioWithMultipleContactsPerDomain() {
        // Arrange
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Empire', Id = '001000000000001'),
            new Account(Name = 'Rebel Alliance', Id = '001000000000002'),
            new Account(Name = 'Jedi Order', Id = '001000000000003')
        };
        
        List<Contact> contacts = new List<Contact>{
            new Contact(Email = 'vader@imperial.emp', AccountId = '001000000000001'),
            new Contact(Email = 'palpatine@imperial.emp', AccountId = '001000000000001'),
            new Contact(Email = 'leia.organa@alliance.reb', AccountId = '001000000000002'),
            new Contact(Email = 'gial.ackbar@issa.trp', AccountId = '001000000000002'),
            new Contact(Email = '', AccountId = '001000000000003'),
            new Contact(Email = 'The Force', AccountId = '001000000000003')
        };
        
        Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>{
            'Empire' => new Map<String, Integer>{'imperial.emp' => 2},
            'Rebel Alliance' => new Map<String, Integer>{'alliance.reb' => 1, 'issa.trp' => 1},
            'Jedi Order' => new Map<String, Integer>()
        };
        
        // Act
        Map<String, Map<String, Integer>> result = 
            MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(accounts, contacts);
        
        // Assert
        Assert.areEqual(expected, result, 
            'Should correctly count multiple contacts per domain and handle mixed valid/invalid emails');
    }
    
    @isTest
    static void testVariousValidEmailFormats() {
        // Arrange
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Test Corp', Id = '001000000000001')
        };
        
        List<Contact> contacts = new List<Contact>{
            new Contact(AccountId = '001000000000001', Email = 'simple@example.com'),
            new Contact(AccountId = '001000000000001', Email = 'simple@example.co'),
            new Contact(AccountId = '001000000000001', Email = 'user123@example.com'),
            new Contact(AccountId = '001000000000001', Email = 'first.last@example.com'),
            new Contact(AccountId = '001000000000001', Email = 'user-name@test-domain.com'),
            new Contact(AccountId = '001000000000001', Email = 'user_name@example.com'),
            new Contact(AccountId = '001000000000001', Email = 'test@domain.international')
        };
        
        Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>{
            'Test Corp' => new Map<String, Integer>{
                'example.com' => 4,
                'example.co' => 1,
                'test-domain.com' => 1,
                'domain.international' => 1
            }
        };
        
        // Act
        Map<String, Map<String, Integer>> result = 
            MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(accounts, contacts);
        
        // Assert
        Assert.areEqual(expected, result, 
            'Should accept various valid email formats including numbers, dots, hyphens, underscores, and long TLDs');
    }
}