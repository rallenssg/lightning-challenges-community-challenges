public with sharing class MapAccountsToEmailDomainCountsSolution {
	/**
	 * Method to calculate the number of Contact records per unique Contact email domain grouped by Account Name
	 *
	 * @param accounts List of Account records to group email domain counts
	 * @param contacts List of Contact records to identify unique email domains and tie counts to Account records from accounts input List
	 * 
	 * @return Map of Account Names as the outer keys pointing to Maps of unique Contact email domains pointing to the count of Contacts with matching the email domain keys as the values
	 */
	public static Map<String,Map<String,Integer>> mapAccountDomainsToContactCounts(List<Account> accounts, List<Contact> contacts) {
		// Write your code here
		System.debug('Debug: accounts=' + accounts + ' contacts=' + contacts);

		// Early return for null or empty input Map
		if (accounts == null || accounts.isEmpty()) return new Map<String,Map<String,Integer>>();

		// Output Map initializer
		Map<String,Map<String,Integer>> acctEmailDomainCountMap = new Map<String,Map<String,Integer>>();
		
		// Loop through records in the accounts parameter
		for(Account acct: accounts) {
			// If the current Account record or Account.Id is null or the current Account Name is empty (null or length == 0), skip this iteration
			if(acct == null || String.isEmpty(acct.Name)) continue;

			// Put current Account Name into output Map as the key and initialize an empty Map as the value
			acctEmailDomainCountMap.put(acct.Name, new Map<String,Integer>());
			
			// Loop through records in the contacts parameter
			for(Contact con: contacts) {
				// If the current Contact record is null or the current Contact's AccountId or Email fields are empty (null or length == 0), skip this iteration
				if(con == null || String.isBlank(con.AccountId) || String.isBlank(con.Email)) continue;

				// TODO: continue here
			}	
			
		}

		return acctEmailDomainCountMap;
	}
}
