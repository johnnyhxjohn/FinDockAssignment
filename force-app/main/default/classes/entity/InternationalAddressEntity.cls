public class InternationalAddressEntity implements IAddressEntity{
    private static final String STATUS_VERIFIED = 'Verified';

    public String address1;
    public String address2;
    public Components components;
    public Metadata metadata;
    public Analysis analysis;

    public Boolean isValid() {
        return (analysis.verification_status==STATUS_VERIFIED);
    }

    public class Components {
        public String administrative_area;
        public String administrative_area_iso2;
        public String country_iso_3;
        public String locality;
        public String dependent_locality;
        public String postal_code;
        public String postal_code_short;
        public String premise;
        public String premise_number;
        public String thoroughfare;
    }

    public class Metadata {
        public Double latitude;
        public Double longitude;
        public String geocode_precision;
        public String max_geocode_precision;
        public String address_format;
    }

    public class ComponentChanges {
        public String administrative_area;
        public String administrative_area_iso2;
        public String country_iso_3;
        public String locality;
        public String dependent_locality;
        public String postal_code;
        public String postal_code_short;
        public String premise;
        public String premise_number;
        public String thoroughfare;
    }
    
    public class Changes {
        public ComponentChanges components;

    }

    public class Analysis {
        public String verification_status;
        public String address_precision;
        public String max_address_precision;
        public Changes changes;

    }
}
