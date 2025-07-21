@isTest
public with sharing class MapAccountsToEmailDomainCountsTest {
	static List<Account> accounts;
	static List<Contact> contacts;
	static Map<String, Map<String, Integer>> expected;

	@isTest
	static void testCalculateEmailDomainUsageNullorEmptyAccounts() {
		// Arrange - set up required data
		if (!setContacts(false)) // set accounts == null
			Assert.fail('Test Null Accounts: Contacts could not be set');

		setExpected();

		// Act - call method to be tested
		Map<String, Map<String, Integer>> nullResult = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		setAccounts(false); // set accounts == {}

		Map<String, Map<String, Integer>> emptyResult = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(
			expected,
			nullResult,
			'Empty Map should be returned when accounts input is null'
		);

		Assert.areEqual(
			expected,
			emptyResult,
			'Empty Map should be returned when accounts input is empty'
		);
	}

	@isTest
	static void testCalculateEmailDomainUsageNullOrEmptyContacts() {
		// Arrange - set up required data
		setAccounts(true); // set contacts == null
		setExpected(true, false);

		// Act - call method to be tested
		Map<String, Map<String, Integer>> nullResult = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		if(!setContacts(false)) // set contacts == {}
			Assert.fail('Test Null Contacts: Contacts could not be set');

		Map<String, Map<String, Integer>> emptyResult = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(
			expected,
			nullResult,
			'Account Names should be outer keys with empty inner Maps when contacts input is null'
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(
			expected,
			emptyResult,
			'Account Names should be outer keys with empty inner Maps when contacts input is empty'
		);
	}

	@isTest
	static void testCalculateEmailDomainUsageAccountEdgeCases() {
		// Arrange - set up required data
		setInputs(false,false);
		Account a;
		accounts.add(a); // null Account
		accounts.add(
			new Account(Name = '', Id = '001000000000001') // blank Name Account
		);
		accounts.add(
			new Account(Id = '001000000000002') // null Name Account
		);
		accounts.add(
			new Account(Name = 'Test 2') // null Id Account
		);

		// Act - call method to be tested
		Map<String, Map<String, Integer>> result = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(
			expected,
			result,
			'Expected empty Map for invalid Accounts'
		);
	}

	@isTest
	static void testCalculateEmailDomainUsageContactEdgeCases() {
		// Arrange - set up required data
		setInputs(true, false);
		Contact c;
		contacts.add(c); // null Contact
		contacts.add(
			new Contact(AccountId = '001000000000001') // null Email Contact
		);
		contacts.add(
			new Contact(AccountId = '001000000000002', Email = '') // Empty Email Contact
		);
		contacts.add(
			new Contact(Email = 'test@fake.com') // null AccountId Contact
		);
		contacts.add(
			new Contact(AccountId = '001000000000004', Email = 'test@fake.com') // Invalid AccountId Contact
		);
		contacts.add(
			new Contact(AccountId = '001000000000001', Email = 'test@test@fake.com') // invalid Email Contact: multiple @ symbols
		);
		contacts.add(
			new Contact(AccountId = '001000000000001', Email = 'test@fake.c') // invalid Email Contact: single character TLD (top level domain)
		);
		contacts.add(
			new Contact(AccountId = '001000000000001', Email = '@fake.com') // invalid Email Contact: no username
		);
		contacts.add(
			new Contact(AccountId = '001000000000002', Email = 't est@fake.com') // invalid Email Contact: space in email
		);
		contacts.add(
			new Contact(AccountId = '001000000000002', Email = 'test@') // invalid Email Contact: no domain
		);
		contacts.add(
			new Contact(AccountId = '001000000000003', Email = 'testatfake.com') // invalid Email Contact: no @ symbol
		);
		contacts.add(
			new Contact(AccountId = '001000000000003', Email = 'test@fakecom') // invalid Email Contact: no TLD (top level domain)
		);
		contacts.add(
			new Contact(AccountId = '001000000000003', Email = 'test#$%@fakecom') // invalid Email Contact: invalid characters
		);

		// Act - call method to be tested
		Map<String, Map<String,Integer>> result = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(expected, result, 'Expected output Map to have Account Names as outer keys and empty inner maps as values when Contacts are invalid');
	}

	@IsTest
	static void testCalculateEmailDomainUsage() {
		setInputs(true, true);

		// Act - call method to be tested
		Map<String, Map<String,Integer>> result = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(accounts, contacts);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(expected, result, '');
	}

	/**
	 * Set up required data
	 *
	 * @param doPopulateAccounts Boolean indicating whether to populate accounts with data
	 * @param doPopulateContacts Boolean indicating whether to populate contacts with data
	 *
	 * @return Boolean true if successful, false otherwise
	 */
	private static Boolean setInputs(Boolean doPopulateAccounts, Boolean doPopulateContacts) {
		if (doPopulateContacts && !doPopulateAccounts)
			return false; // must populate accounts first

		setExpected(doPopulateAccounts, doPopulateContacts);
		setAccounts(doPopulateAccounts);
		return setContacts(doPopulateContacts);
	}

	/**
	 * Set up Accounts test data
	 *
	 * @param doPopulate Boolean indicating whether to populate accounts with data
	 */
	private static void setAccounts(Boolean doPopulate) {

		if(doPopulate) accounts = new List<Account>{
											new Account(Name = 'Empire', Id = '001000000000001'),
											new Account(Name = 'Rebel Alliance', Id = '001000000000002'),
											new Account(Name = 'Jedi Order', Id = '001000000000003')
									};
		else
			accounts = new List<Account>();
	}

	/**
	 * Set up Contacts test data
	 *
	 * @param doPopulate Boolean indicating whether to populate contacts with data
	 *
	 * @return Boolean true if successful, false otherwise
	 */
	private static Boolean setContacts(Boolean doPopulate) {
		contacts = new List<Contact>();

		if(doPopulate && (accounts == null || accounts.isEmpty()))
			return false;

		if(doPopulate)
			contacts.addAll(
				new List<Contact>{
					new Contact(Email = 'vader@imperial.emp', AccountId = '001000000000001'),
					new Contact(Email = 'palpatine@imperial.emp', AccountId = '001000000000001'),
					new Contact(Email = 'leia.organa@alliance.reb', AccountId = '001000000000002'),
					new Contact(Email = 'gial.ackbar@issa.trp', AccountId = '001000000000002'),
					new Contact(Email = '', AccountId = '001000000000003'),
					new Contact(Email = 'The Force', AccountId = '001000000000003')
				}
			);

		return true;
	}

	/**
	 * Set expected reults
	 */
	private static void setExpected() {
		expected = new Map<String, Map<String, Integer>>();
	}

	/**
	 * Set expected results
	 *
	 * @param doPopulateAccounts Boolean indicating whether accounts is populated with data
	 * @param doPopulateContacts Boolean indicating whether contacts is populated with data
	 */
	private static void setExpected(Boolean doPopulateAccounts, Boolean doPopulateContacts) {
		if(doPopulateContacts && !doPopulateAccounts) return;

		if(doPopulateContacts)
			expected = new Map<String, Map<String, Integer>>{
				'Empire' => new Map<String, Integer>{'imperial.emp' => 2},
				'Rebel Alliance' => new Map<String, Integer>{'alliance.reb' => 1, 'issa.trp' => 1},
				'Jedi Order' => new Map<String, Integer>{}
			};

		else if(doPopulateAccounts)
			expected = new Map<String, Map<String, Integer>>{
				'Empire' => new Map<String, Integer>(),
				'Rebel Alliance' => new Map<String, Integer>(),
				'Jedi Order' => new Map<String, Integer>()
			};

		else
			setExpected();
	}
}
