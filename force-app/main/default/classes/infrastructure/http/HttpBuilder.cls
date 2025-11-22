/*
*   Layer responsible to handle generic methods like "build/send" request and extend to classes executing callouts
*/
public with sharing class HttpBuilder {
    protected Http http;
    protected HttpRespnse httpRespnse;
    protected HttpRequest httpRequest;

    public HttpBuilder() {}

    public void buildRequest(){};
    public void sendRequest(){};
}