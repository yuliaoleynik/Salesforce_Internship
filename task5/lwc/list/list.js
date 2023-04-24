import { LightningElement, track, wire} from 'lwc';
import {subscribe, publish, MessageContext} from 'lightning/messageService';
import CAR_SELECTED_MESSAGE from '@salesforce/messageChannel/CarSelected__c';
import FILTERS_MESSAGE from '@salesforce/messageChannel/Filters__c';
import getCars from '@salesforce/apex/getRecordDataController.getCars';
import getCarsWithFilters from '@salesforce/apex/getRecordDataController.getCarsWithFilters';
import title from '@salesforce/label/c.car_list_title';

export default class List extends LightningElement
{
    @track cars;
    @track error;
    @wire(MessageContext) messageContext;
    filtersMessageSubscription;

    card_title = title;

    connectedCallback() {
        this.loadCars();
        this.subscribeFiltersMessageChannel();
    }

    loadCars() {
        getCars()
            .then(result => {
                this.cars = result;
            })
            .catch(error => {
                this.error = error;
            });
    }

    loadCarsWithFilters(category, make, keyWord, price)
    {
        getCarsWithFilters({category : category, make : make, keyWord : keyWord, price : price})
            .then(result => {
                this.cars = result;
            })
            .catch(error => {
                this.error = error;
            });
    }

    handleCarSelected(event) {
        publish(this.messageContext, CAR_SELECTED_MESSAGE, {
            carId: event.detail
        });
    }

    subscribeFiltersMessageChannel()
    {
        if(this.filtersMessageSubscription)
        {
            return;
        }
        this.filtersMessageSubscription = subscribe(
            this.messageContext,
            FILTERS_MESSAGE,
            (message) => { this.loadCarsWithFilters(message.category, message.make, message.keyWord, message.price); }
        );
    }
}