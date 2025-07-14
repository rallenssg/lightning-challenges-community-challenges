public with sharing class MapAccountsToEmailDomainCountsSolution {
	/**
	 * Method to calculate the number of Contact records per unique Contact email domain grouped by Account Name
	 *
	 * @param accounts List of Account records to group email domain counts
	 * @param contacts List of Contact records to identify unique email domains and tie counts to Account records from accounts input List
	 * 
	 * @return Map of Account Names as the outer keys pointing to Maps of unique Contact email domains pointing to the count of Contacts with matching the email domain keys as the values
	 */
	public static Map<String,Map<String,Integer>> calculateEmailDomainUsageByAccount(List<Account> accounts, List<Contact> contacts) {

		// Early return for null or empty Accounts
        if (accounts == null || accounts.isEmpty()) return new Map<String,Map<String,Integer>>();

        // Output Map initializer
        Map<String,Map<String,Integer>> acctEmailDomainCountMap = new Map<String,Map<String,Integer>>();
        
        // Create Account Id to Name mapping for O(1) lookups
        Map<Id, String> accountIdToName = new Map<Id, String>();
        
        // Initialize all Account Names in output map
        for(Account acct: accounts) {
            
            if(acct == null || String.isEmpty(acct.Name) || String.isEmpty(acct.Id)) continue;

            if(acctEmailDomainCountMap.containsKey(acct.Name)) continue;

            acctEmailDomainCountMap.put(acct.Name, new Map<String,Integer>()); // initialize inner Map
            accountIdToName.put(acct.Id, acct.Name);
        }
        
        // Early return for empty contacts
        if(contacts == null || contacts.isEmpty()) return acctEmailDomainCountMap;
        
        // Process Contacts once
        for(Contact con: contacts) {

            if(con == null || !accountIdToName.containsKey(con.AccountId) || !isEmailValid(con.Email)) continue;
            
            String emailDomain = con.Email.substringAfter('@'); // Get current Contact's email domain

            Map<String,Integer> domainCountMap = acctEmailDomainCountMap.get(accountIdToName.get(con.AccountId)); // Get current Account's email domain count map
            
            // Use a single variable to avoid double map lookup
            Integer currentCount = domainCountMap.get(emailDomain);

            domainCountMap.put(emailDomain, currentCount == null ? 1 : currentCount + 1);
        }
        
        return acctEmailDomainCountMap;
    }

    /**
     * Validates if the provided string is a properly formatted email address
     * 
     * @param email The email string to validate
     * @return Boolean true if email format is valid, false otherwise
     */
    private static Boolean isEmailValid(String email) {
        // Check for null or empty
        if (String.isBlank(email)) return false;
        
        // Basic email pattern check using APEX regex
        // Pattern explanation:
        // - One or more word characters, dots, hyphens, or underscores
        // - @ symbol
        // - One or more word characters or hyphens
        // - Dot
        // - Two or more word characters (domain extension)
        String emailRegex = '^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$';
        Pattern emailPattern = Pattern.compile(emailRegex);
        Matcher matcher = emailPattern.matcher(email);
        
        return matcher.matches();
    }
}
