List<Contact> lstCon = [Select Id, Name, Title, Phone, Email, Icon__c, Rank__C, AccountId, Account.Name from Contact Where AccountId != null LIMIT 10 ];
       if(!lstCon.isEmpty())
       {
        for(Contact con:lstCon)
        {
            con.Icon__c='https://yt3.googleusercontent.com/k4qc9MqwK_3BHEXmpQXn0EsvUrGQlCdx0sgOgcC32CcMfHb9MraznmGnmQA4QmLH3xJCQZWp=s900-c-k-c0x00ffffff-no-rj';
            if(String.isBlank(con.Title))
            {
                con.Rank__C=3;
            }
            else
            {
                con.Rank__C=6;
            }
        }
        update lstCon;
       }