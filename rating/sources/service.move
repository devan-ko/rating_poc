module rating::service {
    use std::string::String;
    use sui::balance::{Self,Balance};
    use sui::vec_set::{Self,VecSet};
    use std::vector;

    use review::Review;
    //Error codes
    const EUserAlreadyExists: u32 = 0;
    // Constants

    // structs
    struct OwnerCap has key { id: UID }

    struct ServiceLists has key, store {
        id: UID,
        service_list: VecSet<SERVICE>,
    }

    struct SERVICE has key, store, drop {
        id: UID,
        owner: address,
        pool: POOL,
        cuisine_type: String,
        location: String,
        google_map_url: String,
        operating_hours: String,
        url: String,
        pictures_urls: vector<u8>,
        verified_user_lists: VecSet<address>,
        review_list: vec<Review>,
        rating: u8,
    }

    struct VerfriedUser has key { id: UID }

    struct POOL has key, store, drop {
        id: UID,
        pool_address: address,
        provided_incentive: Balance<SUI>,
    }

    // struct SERVICE_OWNER has key, store, drop {
    //     id: UID,
    //     service_list: VecSet<SERVICE>,
    // }

    // public view functions
    public fun owner(service: &SERVICE): address {
        service.owner
    }

    public fun pool(service: &SERVICE): {address, Balance<SUI>} {
       pool_details(&service.pool)
    }

    public fun pool_details(pool: &POOL): {address, Balance<SUI>} {
        {pool.addr, pool.balance}
    }

    public fun cuisine_type(service: &SERVICE): String {
        service.cuisine_type
    }

    public fun location(service: &SERVICE): String {
        service.location
    }

    public fun google_map_url(service: &SERVICE): String {
        service.google_map_url
    }

    public fun operating_hours(service: &SERVICE): String {
        service.operating_hours
    }

    public fun url(service: &SERVICE): String {
        service.service_url
    }

    public fun pictures_urls(service: &SERVICE): vector<u8> {
        assert!(service.service_pictures_url.len() > 0, "No pictures uploaded"
        service.service_pictures_url
    }

    public fun verified_user_lists(service: &SERVICE): &VecSet<address> {
        service.verified_user_lists
    }

    public fun rating(service: &SERVICE): u8 {
        service.rating
    }

    // init
    


    // verified user register
    public fun register_verified_user(service: &SERVICE, user: address) {
        assert!(user_duplicated(user, service),EUserAlreadyExists);
        let mut existing_lists = verified_user_lists(service);
        existing_lists.insert<address>(user);
    }

    public fun user_duplicated(user: address, service: &SERVICE): bool {
        let lists = verified_user_lists(&service);
        lists.contains<address>(user)
    }

    // pool create 
    public fun create_incentive_pool(
        _: &OwnerCap,

    ){

    }

    // service register
    public fun register_service(
        _: &OwnerCap,
        owner: address,
        cuisine_type: String,
        location: String,
        google_map_url: String,
        operating_hours: String,
        url: String,
        pictures_urls: vector<u8>,
        provided_incentive_amount: Balance<SUI>,
    ) {

        
    }

    //send review incentive

    //add review to service :: Using Dynamic fields







}