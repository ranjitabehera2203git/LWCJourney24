public with sharing class weatherDeteailsClass {
    @AuraEnabled
    public static WeatherWrapper getWeatherDetails (String passCityName)
    {
        String endPoint='https://api.openweathermap.org/data/2.5/weather?q='+ passCityName +'&units=metric&appid=3e9abff2db22a7783186295839c8c79b';
        Http htp=new Http();
        HttpRequest hReq=new HttpRequest();
        hReq.setEndpoint(endpoint);
        hReq.setMethod('GET');
        HttpResponse hResp = htp.send(hReq);
        System.debug('  hResp ----> '+hResp);
        System.debug('  Body ----> '+hResp.getBody());
        System.debug('  deserialize Body ----> '+ JSON.deserializeUntyped(hResp.getBody()));

        WeatherWrapper wrapObject=new WeatherWrapper();
        if(hResp.getStatusCode() == 200)       
         {
            System.JSONParser jParser=System.JSON.createParser(hResp.getBody());
            while(jParser.nextToken() != null)
            {
                if(jParser.getText() == 'name')
                {
                    jParser.nextToken();
                    wrapObject.wcityName =jParser.getText();
                }
                if(jParser.getText() == 'grnd_level')
                {
                    jParser.nextToken();
                    wrapObject.grandLevel=jParser.getText();
                }
                if(jParser.getText() == 'humidity')
                {
                    jParser.nextToken();
                    wrapObject.humidity=jParser.getText();
                }
                if(jParser.getText() == 'pressure')
                {
                    jParser.nextToken();
                    wrapObject.pressure=jParser.getText();
                }
                if(jParser.getText() == 'sea_level ')
                {
                    jParser.nextToken();
                    wrapObject.seaLevel=jParser.getText();
                }
                if(jParser.getText() == 'temp')
                {
                    jParser.nextToken();
                    wrapObject.temp=jParser.getText();
                }
                if(jParser.getText() == 'temp_max')
                {
                    jParser.nextToken();
                    wrapObject.tempMax=jParser.getText();
                }
                if(jParser.getText() == 'temp_min')
                {
                    jParser.nextToken();
                    wrapObject.tempMin=jParser.getText();
                }
            } 
        }   
    
    System.debug(' return wrapObject; '+  wrapObject);
    return wrapObject;   
}

    public class WeatherWrapper
    {
        @AuraEnabled public String wcityName;
        @AuraEnabled public String feelsLike ;
        @AuraEnabled public String grandLevel;
        @AuraEnabled public String humidity;
        @AuraEnabled public String pressure{get;set;}
        @AuraEnabled public String seaLevel{get;set;}
        @AuraEnabled public String temp{get;set;}
        @AuraEnabled public String tempMin{get;set;}
        @AuraEnabled public String tempMax{get;set;}
    }
}