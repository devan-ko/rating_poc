# Review / Rating app

- This documentation draws relevant entities & corresponding objects in the Review/Rating app. 
- Summary
   - Entities will be Service registry as a shared object; This objects will be able to make distiguished what are registered services.
   - Service owner will has its own services which are registered to the Service registry object
   - Certified reviewer has its own authorized consumers lists who could access full review written by. 
   - Authorized consumer doesn't have relevant 
## Entities

- Below sub topic explain about relevant entities in this PoC. 

### Service Registry

```
struct Registry has key, store, drop {
    id: UID,
    list: VecSet<Service>

}
```
-----
Service registry will be shared object & deploy to the Sui network. 
Service owners will be register owned Services object to list. and this will be using in backend for service browsing.
-----

### Service Owner

```
struct Service has key, store, drop {

}
```

### Certified reviewer

```
struct reviewer has key, store, drop {

}
```


## Corresponding Objects

### Service

### Review


## Backend APIs

### Service registry
- Parse & return of the registered services list necessary
  - This would working as an asynchronous manner.
  - Method : Get
  - Offset necessary for page.

- 

## Interaction Diagram

