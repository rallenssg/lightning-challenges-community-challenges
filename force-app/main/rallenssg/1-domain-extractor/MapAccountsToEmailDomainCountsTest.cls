@isTest
public with sharing class MapAccountsToEmailDomainCountsTest {
	static List<Account> accounts;
	static List<Contact> contacts;

	@isTest
	static void testCalculateEmailDomainUsageNullAccounts() {
		// Arrange - set up required data
		if (!setContacts(false))
			Assert.fail('Test Null Accounts: Contacts could not be set');
		Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>();

		// Act - call method to be tested
		Map<String, Map<String, Integer>> result = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(
			expected,
			result,
			'Empty Map should be returned when accounts input is null'
		);
	}

	@isTest
	static void testCalculateEmailDomainUsageEmptyAccounts() {
		// Arrange - set up required data
		if (!setInputs(false, false))
			Assert.fail('Test Empty Accounts: Inputs could not be set');
		Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>();

		// Act - call method to be tested
		Map<String, Map<String, Integer>> result = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(
			expected,
			result,
			'Empty Map should be returned when accounts input is empty'
		);
	}

	@isTest
	static void testCalculateEmailDomainUsageNullContacts() {
		// Arrange - set up required data
		setAccounts(true);
		Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>{
			'Empire' => new Map<String, Integer>(),
			'Rebel Alliance' => new Map<String, Integer>(),
			'Jedi Order' => new Map<String, Integer>()
		};

		// Act - call method to be tested
		Map<String, Map<String, Integer>> result = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(
			expected,
			result,
			'Account Names should be outer keys with empty inner Maps when contacts input is null'
		);
	}

	@isTest
	static void testCalculateEmailDomainUsageEmptyContacts() {
		// Arrange - set up required data
		setInputs(true, false);
		Map<String, Map<String, Integer>> expected = new Map<String, Map<String, Integer>>{
			'Empire' => new Map<String, Integer>(),
			'Rebel Alliance' => new Map<String, Integer>(),
			'Jedi Order' => new Map<String, Integer>()
		};

		// Act - call method to be tested
		Map<String, Map<String, Integer>> result = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(
			accounts,
			contacts
		);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(expected, result, '');
	}

	/**
	 * // Arrange - set up required data
		Map<String, Map<String,Integer>> expected = new Map<String, Map<String,Integer>>();

		// Act - call method to be tested
		Map<String, Map<String,Integer>> result = MapAccountsToEmailDomainCountsSolution.calculateEmailDomainUsageByAccount(accounts, contacts);

		// Assert - ensure expected outcome occurs
		Assert.areEqual(expected, result, '');
	 */

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

		setAccounts(doPopulateAccounts);
		return setContacts(doPopulateContacts);
	}

	/**
	 * Set up Accounts test data
	 *
	 * @param doPopulate Boolean indicating whether to populate accounts with data
	 */
	private static void setAccounts(Boolean doPopulate) {
		accounts = new List<Account>();

		if (doPopulate)
			accounts.addAll(
				new List<Account>{
					new Account(Name = 'Empire', Id = '001000000000001'),
					new Account(Name = 'Rebel Alliance', Id = '001000000000002'),
					new Account(Name = 'Jedi Order', Id = '001000000000003')
				}
			);
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

		if (doPopulate && (accounts == null || accounts.isEmpty()))
			return false;

		if (doPopulate)
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

	// @isTest
	// static void testBasicCase() {
	// 	// Arrange
	// 	String input = 'test';
	// 	String expected = 'expected result';

	// 	// Act
	// 	String result = ChallengeSolution.sampleMethod(input);

	// 	// Assert
	// 	Assert.areEqual(expected, result, 'Should return expected result for basic input');
	// }

	// @isTest
	// static void testEdgeCase() {
	// 	// Arrange
	// 	String input = '';
	// 	String expected = '';

	// 	// Act
	// 	String result = ChallengeSolution.sampleMethod(input);

	// 	// Assert
	// 	Assert.areEqual(expected, result, 'Should handle empty string correctly');
	// }

	// @isTest
	// static void testNullInput() {
	// 	// Arrange
	// 	String input = null;
	// 	String expected = null;

	// 	// Act
	// 	String result = ChallengeSolution.sampleMethod(input);

	// 	// Assert
	// 	Assert.areEqual(expected, result, 'Should handle null input appropriately');
	// }

	// @isTest
	// static void testAnotherCase() {
	// 	// Arrange
	// 	String input = 'another test';
	// 	String expected = 'another expected result';

	// 	// Act
	// 	String result = ChallengeSolution.sampleMethod(input);

	// 	// Assert
	// 	Assert.areEqual(expected, result, 'Should handle different input correctly');
	// }

	// @isTest
	// static void testSpecialCharacters() {
	// 	// Arrange
	// 	String input = 'special@chars#123';
	// 	String expected = 'expected special result';

	// 	// Act
	// 	String result = ChallengeSolution.sampleMethod(input);

	// 	// Assert
	// 	Assert.areEqual(expected, result, 'Should handle special characters correctly');
	// }

	// @isTest
	// static void testWhitespaceInput() {
	// 	// Arrange
	// 	String input = '   ';
	// 	String expected = 'default result';

	// 	// Act
	// 	String result = ChallengeSolution.sampleMethod(input);

	// 	// Assert
	// 	Assert.areEqual(expected, result, 'Should handle whitespace-only input correctly');
	// }
}
