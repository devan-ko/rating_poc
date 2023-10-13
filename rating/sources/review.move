module rating::review {
    // Functional requirements
    // - Reviewer is also can be consumer
    // - Reviewer can post review to service
    // - 

    use sui::object::{Self, UID};
    use std::string::String;
    use std::vector;
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    // Error codes
    const EIsNotAuthorizedUser:u8 = 0;

    // Contants

    // structs

    // struct reviewer has key, store{
    //     id:UID,

    // }

    struct Review has key, store{
        id:UID, 
        head: String,
        body: String,
        up_vote: u8,
        down_vote: u8,
        writer: address,
        full_view_authorized_users: vector<address>,
    }

    // struct User has key, store{
    //     id: UID,
    //     user_address: address,
    //     revealed_review_list: Vec<UID>,
    // }

     // ===== Public view functions =====
    public fun head(review: &Review): &String {
        review.head
    }
    public fun body(review: &Review): &String {
        review.body_full
    }
    public fun rating(review: &Review): u8 {
        review.rating
    }
    public fun vote(review: &Review): (u8,u8) {
        (&review.up_vote, &review.down_vote)
    }
    public fun writer(review: &Review): address {
        review.writer
    }
    public fun full_view_authorized_users(review: &Review): vector<address> {
        review.full_view_authorized_users
    }

    // register auhtourized user
    public fun register_authorized_user(review: &Review, user: address) {
        let list = full_view_authorized_users(review);
         vector::push_back(&mut list, user);
    }

    public fun is_authorized_user(review: &Review, user: address):bool {
        let user_lists = full_view_authorized_users(review);
        if (vector::contains(user_lists, user)) {
            true;
        } else {
           false;
        };
    }

    public fun post_to_service(
        head: String,
        body: String,
        writer: address,
        full_view_authorized_users: vector<address>,
        service: address,
        ctx: &mut TxContext
    ) {
        let review_body = body;
        sender = tx_context::sender(ctx);
        let review = Review{
            id: object::id(ctx),
            body: review_body,
            up_vote: 0,
            down_vote: 0,
            writer: sender,
            full_view_authorized_users: vector::empty()
        };

        transfer::public_transfer(review, service)
    }
    






}