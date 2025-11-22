@IsTest(IsParallel=true)
public class TestAddressValidationCallout {

    @IsTest
    public static void whenCalloutIsSuccess() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('MockValidAddressUS');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        String street ='1428 Post Aly';
        String city = 'Seattle';
        String state = 'WA';
        Test.startTest();
        IAddressEntity entityResponse = AddressValidationCallout.validateAddressUS(street, city, state);
        Test.stopTest();
        Assert.areNotEqual(entityResponse, null);
        Assert.areEqual(entityResponse.isValid(), true);
    }

    @IsTest
    public static void whenCalloutSucceedButEmptyResponse() {
        // TODO
    }

    @IsTest
    public static void whenCalloutFailsUnhautorized() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('MockValidAddressUS');
        mock.setStatusCode(401);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);

        String street ='1428 Post Aly';
        String city = 'Seattle';
        String state = 'WA';

        Test.startTest();
        String entityResponse = AddressValidationCallout.buildRequest('http://myendpoint.com');
        Test.stopTest();

        Assert.areEqual(entityResponse, null);
    }
}