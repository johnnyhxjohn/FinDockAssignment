public class USAddressEntity implements IAddressEntity{
    private static final String STATUS_PRECISION_NONE = 'none'; // Unknown
    private static final String STATUS_PRECISION_UNKNOWN = 'Unknown'; // Unknown

    public Integer input_index;
    public Integer candidate_index;
    public String delivery_line_1;
    public String last_line;
    public String delivery_point_barcode;
    public String smarty_key;
    public Components components;
    public Metadata metadata;
    public Analysis analysis;

    public Boolean isValid() {
        return (metadata.precision!=STATUS_PRECISION_NONE && metadata.precision != STATUS_PRECISION_UNKNOWN);
    }

    public class Components {
        public String primary_number;
        public String street_predirection;
        public String street_name;
        public String street_suffix;
        public String city_name;
        public String default_city_name;
        public String state_abbreviation;
        public String zipcode;
        public String plus4_code;
        public String delivery_point;
        public String delivery_point_check_digit;
    }

    public class Metadata {
        public String record_type;
        public String zip_type;
        public String county_fips;
        public String county_name;
        public String carrier_route;
        public String congressional_district;
        public String rdi;
        public String elot_sequence;
        public String elot_sort;
        public Double latitude;
        public Double longitude;
        public Integer coordinate_license;
        public String precision;
        public String time_zone;
        public Integer utc_offset;
        public Boolean dst;
    }

    public class Analysis {
        public String dpv_match_code;
        public String dpv_footnotes;
        public String dpv_cmra;
        public String dpv_vacant;
        public String dpv_no_stat;
        public String active;
        public String enhanced_match;
    }

    // // ---- Factory method to deserialize a list ----
    // public static List<USAddressResponse> fromJson(String jsonString) {
    //     return (List<USAddressResponse>) JSON.deserialize(
    //         jsonString,
    //         List<USAddressResponse>.class
    //     );
    // }
}
