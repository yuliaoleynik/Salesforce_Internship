import {LightningElement, wire} from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import CAR_SELECTED_MESSAGE from '@salesforce/messageChannel/CarSelected__c';
import { NavigationMixin } from 'lightning/navigation';

import { getFieldValue } from 'lightning/uiRecordApi';

import CAR_OBJECT from '@salesforce/schema/Car__c';
import NAME_FIELD from '@salesforce/schema/Car__c.Name';
import CATEGORY_FIELD from '@salesforce/schema/Car__c.Category__c';
import MAKE_FIELD from '@salesforce/schema/Car__c.Make__c';
import MSRP_FIELD from '@salesforce/schema/Car__c.MSRP__c';
import FUEL_TYPE_FIELD from '@salesforce/schema/Car__c.Fuel_Type__c';
import PICTURE_URL_FIELD from '@salesforce/schema/Car__c.Picture_URL__c';
import NUMBER_OF_SEATS_FIELD from '@salesforce/schema/Car__c.Number_of_Seats__c';
import CONTROL_FIELD from '@salesforce/schema/Car__c.Control__c';

import category_label from '@salesforce/label/c.category_label';
import make_label from '@salesforce/label/c.make_label';
import msrp_label from '@salesforce/label/c.msrp_label';
import fuel_label from '@salesforce/label/c.fuel_label';
import seats_label from '@salesforce/label/c.seats_label';
import control_label from '@salesforce/label/c.control_label';
import border_label from '@salesforce/label/c.border_label';

export default class Detail extends NavigationMixin(LightningElement)
{
    recordId;

    categoryField = CATEGORY_FIELD;
    makeField = MAKE_FIELD;
    msrpField = MSRP_FIELD;
    fuelTypeField = FUEL_TYPE_FIELD;
    numberOfSeatsField = NUMBER_OF_SEATS_FIELD;
    controlField = CONTROL_FIELD;

    carName;
    carPictureUrl;

    @wire(MessageContext) messageContext;
    carSelectionSubscription;

    label = {
        category_label,
        make_label,
        msrp_label,
        fuel_label,
        seats_label,
        control_label,
        border_label,
    }

    connectedCallback() {
        this.carSelectionSubscription = subscribe(
            this.messageContext,
            CAR_SELECTED_MESSAGE,
            (message) => this.handleCarSelected(message.carId)
        );
    }

    handleCarSelected(carId) {
        this.recordId = carId;
    }

    handleRecordLoaded(event) {
        const { records } = event.detail;
        const recordData = records[this.recordId];
        this.carName = getFieldValue(recordData, NAME_FIELD);
        this.carPictureUrl = getFieldValue(recordData, PICTURE_URL_FIELD);
    }

    handleNavigateToRecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: CAR_OBJECT.objectApiName,
                actionName: 'view'
            }
        });
    }
}