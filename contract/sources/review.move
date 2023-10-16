module contract::review {
    // Functional requirements
    // - Reviewer is also can be consumer
    // - Reviewer can post review to service
    // - 
    use sui::coin::{Self, Coin};
    use sui::object::{Self, UID};
    use std::string::String;
    use std::vector;
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::sui::SUI;

    // Error codes
    // Constants
    // Struct
    struct Obj has key, store{
        id: UID, 
        head: String,
        body: String,
        up_vote: u8,
        down_vote: u8,
        total_score: u8,
        decay_rate: u8,
        writer: address,
        minumum_tip: Coin<SUI>,
        full_view_authorized_users: vector<address>,
    }

    // struct AuthorityCap has key {
    //     id: UID,
    // }
    // struct Authorized has key, store{
    //     id: UID,
    //     cap: AuthorityCap, 
    //     authority_owner: address,
    //     user_list: vector<address>,
    // }


    // struct Req_Authority has key {

    // }

     // ===== Public view functions =====
    public fun head(review: &Obj): String {
        review.head
    }
    public fun body(review: &Obj): String {
        review.body
    }
    public fun total_score(review: &Obj): u8 {
        review.total_score
    }
    public fun decay_rate(review: &Obj): u8 {
        review.decay_rate
    }
    public fun vote(review: &Obj): (u8,u8) {
        (review.up_vote, review.down_vote)
    }
    public fun writer(review: &Obj): address {
        review.writer
    }

    public fun tip(review: &Obj): u64 {
       coin::value(& review.minumum_tip)
    }    

    public fun full_view_authorized_users(review: &Obj): vector<address> {
       let list = review.full_view_authorized_users;
       list
    }

    // register auhtourized user
    public fun register_authorized_user(review: &mut Obj, user: address) {
        let list = full_view_authorized_users(review);
        vector::push_back(&mut list, user);
    }

    public fun is_authorized_user(review: &Obj, user: &address): bool {
        let user_lists = &full_view_authorized_users(review);
        vector::contains(user_lists, user)
    }

    public fun post_to_service(
        head_contents: String,
        body_contents: String,
        service: address,
        tip_amount: Coin<SUI>,
        ctx: &mut TxContext) {
        let writer = tx_context::sender(ctx);
        let (review, service_address) = create(head_contents, body_contents, service, writer, tip_amount, ctx);

        transfer::public_transfer(review, service_address)
    }

    public fun create (
        head_contents: String,
        body_contents: String,
        service: address,
        writer_address: address,
        tip_amount: Coin<SUI>,
        ctx: &mut TxContext
    ): (Obj, address) {
        let service_address = service;
        let review = Obj {
            id: object::new(ctx),
            head: head_contents,
            body: body_contents,
            up_vote: 0,
            down_vote: 0,
            total_score: 0,
            decay_rate: 1,
            writer: writer_address,
            minumum_tip: tip_amount,
            full_view_authorized_users: vector::empty<address>(),
        };

        (review, service_address)

    }

    public fun calculate_total_score(
        intrinsic_value: u8, 
        extrinsic_value: u8, 
        decay_rate: u8,
        verfication_multiplier: u8):u8 {
            let total_score = (intrinsic_value + extrinsic_value) * decay_rate * verfication_multiplier;
            total_score
    }

    // public fun send_tip(
    //     reviewer: address,
    //     ctx : &mut TxContext,
    //     tip_amount: Coin<SUI>,
    //     review_obj: address) {
    //         let sender = tx_context::sender(ctx);

    //     }

    


    






}