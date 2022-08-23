#include "malloc.h"
#include "process.h"
//#include "limits.h"
int heap_flag = 0;

/*typedef struct heap_info_struct{
   int num_allocs;
   long * size_array;
   void ** ptr_array;
   int free_space;
   int largest_free_chunk;
} heap_info_struct; */

typedef struct linked{ 
    uint64_t sz;
    int free;
    void *addr;
    struct linked *next;
    struct linked *prev;
} linked;


//head list ptr
linked *head = NULL;

void free(void *firstbyte) {
    if (firstbyte == NULL)
        return;
    linked *curr = head;
    while (curr){
        if (curr->addr == firstbyte) 
            if(curr->free == 1){
                curr->free = 0;
                break;
            }
        curr = curr->next;
    }
    return;
}


void add_block(void *b) {
    linked *temp = (linked *)b;
    temp->next = NULL;
    temp->prev = NULL;
    temp->free = 0;
    if ((uintptr_t)temp <= (uintptr_t)head || head == NULL ){
        if (head != NULL)
            head->prev = temp;
        temp->next = head;
        head = temp;
    }
    else{
        linked *curr = head;
        while ((uintptr_t)temp >= (uintptr_t) curr->next && curr->next != NULL){
            curr = curr->next;
        }
        temp->next = curr->next;
        curr->next = temp;
    }
}

void *malloc(uint64_t numbytes) { 
    if(numbytes < 1)
        return NULL;    
    uint64_t meta_sz = (((numbytes + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))) + (8 - 1)) & ~(8 - 1));
    linked *sized_block = NULL;
    //assign block and search
    linked *curr = head;
    while (curr != NULL){
        if (curr->free == 0)
            if(curr->sz >= numbytes)
                sized_block = curr;
        curr = curr->next;
    }
    if (sized_block == NULL){
        //extra size 
        uint64_t ex_sz = 0;
        if (meta_sz > PAGESIZE){
            ex_sz = meta_sz; 
        }
        else{
            ex_sz = ((PAGESIZE) + (8 - 1)) & ~(8 - 1);
        }
        void *temp_block = (void *)sized_block;
        temp_block = (void *)sbrk(ex_sz);
        if (temp_block == (void *)-1){
            return NULL;
        }
        sized_block = (linked *)temp_block;
        add_block(sized_block);
        sized_block->sz = ex_sz;
        if (heap_flag == 0){
            sized_block->free = 1; //for debugging
        }
        sized_block->addr = (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));

        //splitting
        linked *temp = (linked *)sized_block;
        void *new_ptr = (void *) ((uintptr_t) sized_block + meta_sz);
        //creating splits for blocks, dont need to micromanage for optimal space
        if ((sized_block->sz - meta_sz) < (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))){
            //do nothing, use regular space
        }
        else{
            linked *new_linked = (linked *) new_ptr; //more space
            new_linked->sz = sized_block->sz - meta_sz;
            temp->sz = meta_sz;
            new_linked->free = 0; //flag
            add_block(new_linked);
        }
        //split end

        return (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
    }
    if (heap_flag == 0){
        sized_block->free = 1;
    }
    sized_block->addr = (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
    
    //splitting
    linked *temp = (linked *) sized_block;
    void *new_ptr = (void *) ((uintptr_t) sized_block + meta_sz);
    if ((sized_block->sz - meta_sz) < (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))){
        //same as above
    }
    else{
        linked *new_linked = (linked *) new_ptr;
        new_linked->sz = sized_block->sz - meta_sz;
        temp->sz = meta_sz;
        new_linked->free = 0;
        add_block(new_linked);
    } 
    //splitting end

    return (void *)(uintptr_t)sized_block + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
}


void * calloc(uint64_t num, uint64_t sz) { //done
    void* ptr = NULL;
    //edge case
    if(num == 0)
        return NULL;
    if(sz == 0)
        return NULL;

    if(sz > 0 && num > (4294967294/sz)){
        ptr = NULL;
    }
    else
        ptr = malloc(num * sz);
    
    if (!ptr){
        //nothing
    }
    else
        memset(ptr, 0, num * sz);
    return ptr;
}

void * realloc(void * ptr, uint64_t sz) { //done
    //for it to equal free
    if (sz == 0){ //size must be 0
        if(ptr != NULL){ //ptr cannot be null
            free(ptr); 
            return NULL;
        }
    }
    // for it to be malloc of the sz
    if (ptr == NULL){
        void *temp_ptr = malloc(sz);
        return temp_ptr;
    }
    
    linked *head_ptr = (linked *)(uintptr_t)ptr - (((sizeof(linked)) + (8 - 1)) & ~(8 - 1));
    if (sz < head_ptr->sz)
        return ptr;
    
    uint64_t new_sz = (((sz + (((sizeof(linked)) + (8 - 1)) & ~(8 - 1))) + (8 - 1)) & ~(8 - 1));
    linked *new_loc;
    //overflows?
    if ((((sizeof(linked)) + (8 - 1)) & ~(8 - 1)) > 0)
        if(sz > (4294967294) - (((sizeof(linked)) + (8 - 1)) & ~(8 - 1)))
            return NULL;
    new_loc = malloc(sz);
    if (new_loc == NULL)
        return NULL;
    memcpy(new_loc, ptr, head_ptr->sz);
    free(ptr);
    return new_loc;
}

void defrag(){ //done
    linked *curr = head;
    while(curr != NULL){
        if (curr->free == 0){
            if(curr->next){
                if(curr->next->free == 0){
                    if (curr->prev != NULL && curr->prev->free == 0){
                        curr->prev->sz += curr->sz; 
                    }   
                    else{
                        uint64_t av_sz;
                        av_sz = curr->next->sz;
                        curr->sz += av_sz;
                    }
                }
                //end curr ==
            }
        }
        curr = curr->next;
    }
}

int heap_info(heap_info_struct * info) {
    return 0;
}
