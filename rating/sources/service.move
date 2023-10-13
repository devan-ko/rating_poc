module rating::service {
    // Functional requirements
    // - Service object belongs to a single address
    // - Service object has to be registered by the owner's address 
    // - Service owner address could have various services
    // - Service object has to be provided with relevant information 
    // such as cuisine type, location, google map url, operating hours, url, pictures urls
    // - Service object has to have a pool of incentive to be distributed to users who provide reviews
    // - Service object's pool creation has to be done by the owner
    // - Each service could have its own respective pool
    // - Services belongs to a single address could share the same pool
    // - Service object has verified user list
    // - Service object can add verified user to its list
    // - Service object register to SeriveLists object to show listed services to users
    // 
    use std::string::String;
    use sui::balance::{Self,Balance};
    use sui::vec_set::{Self,VecSet};
    use std::vector;

    use review::Review;
    //Error codes
    const EUserAlreadyExists: u32 = 0;
    // Constants

    // structs
    // OwnerCap will be send to the service owner
    struct OwnerCap has key { id: UID }

    // Service List will show the regiered services to users this will be shared object
    // because of the this Lists has to be amended by the service owner
    struct Registery has key, store {
        id: UID,
        service_list: VecSet<SERVICE>,
    }

    // Service object belongs to a single address
    // It has
    // Its own ID, 
    // Owner's address,
    // Pool object,
    // Cuisine type, location, google map url, operating hours, url, pictures urls
    // Verified user list which is VectorSet of address type
    // VectorSet could be prevent address's duplication
    // Review list which is Vec of Review struct
    // 
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
    // shared object transfer which is Registry
    fun init () {
        let service_list = Registery{
            id: object::new(ctx),
            service_list: VecSet::empty(),
        }
        transfer::share_object(service_list)

    }
    

    // Service register to Service List
    public fun register() {

    }
    
    // service object creation
    public fun create() {

    }

    // pool creation
    public fun create_pool(){

    }
    // link pool to service
    public fun set_pool(_: &OwnerCap, service: &SERVICE, pool: &POOL) {
        service.pool = pool;
    }

    //



    // verified user register
    public fun register_verified_user( _: &OwnerCap, service: &SERVICE, user: address) {
        assert!(user_duplicated(user, service),EUserAlreadyExists);
        let mut existing_lists = verified_user_lists(service);
        existing_lists.insert<address>(user);
    }
    // Prior to adding verified user, Check duplication
    public fun user_duplicated(user: address, service: &SERVICE): bool {
        let lists = verified_user_lists(&service);
        lists.contains<address>(user)
    }

   







}