public with sharing class MapAccountsToEmailDomainCountsTemplate {
	/**
	 * Method to calculate the number of Contact records per unique Contact email domain grouped by Account Name
	 *
	 * @param accounts List of Account records to group email domain counts
	 * @param contacts List of Contact records to identify unique email domains and tie counts to Account records from accounts input List
	 * 
	 * @return Map of Account Names as the outer keys pointing to Maps of unique Contact email domains pointing to the count of Contacts with matching the email domain keys as the values
	 */
	public static Map<String,Map<String,Integer>> calculateEmailDomainUsageByAccount(List<Account> accounts, List<Contact> contacts) {
		// Write your code here
		System.debug('Debug: accounts=' + accounts + '\ncontacts=' + contacts);
		
		return null;
	}
}
