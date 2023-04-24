import {LightningElement, wire} from 'lwc';
import FILTERS_MESSAGE from '@salesforce/messageChannel/Filters__c';
import {MessageContext, publish} from "lightning/messageService";

import search_key_label from '@salesforce/label/c.search_key_label'
import price_slider_label from '@salesforce/label/c.price_slider_label'
import category_label from '@salesforce/label/c.category_label'
import make_label from '@salesforce/label/c.make_label'

export default class Filters extends LightningElement
{
    keyWord;
    @wire(MessageContext) messageContext;
    value = ['option'];
    categoryChecked;
    makeChecked;
    price = 999999;

    label = {
        search_key_label,
        price_slider_label,
        category_label,
        make_label,
    }

    get optionsCategory() {
        return [
            { label: 'Hatchback', value: 'Hatchback' },
            { label: 'MUV', value: 'MUV' },
            { label: 'Sedan', value: 'Sedan' },
            { label: 'SUV', value: 'SUV' },
        ];
    }
    get optionsMake() {
        return [
            { label: 'Ford', value: 'Ford' },
            { label: 'Hyundai', value: 'Hyundai' },
            { label: 'Honda', value: 'Honda' },
            { label: 'Renault', value: 'Renault' },
        ];
    }

    handleSearchKeyChange(event) {
        this.keyWord = event.target.value;
        this.publishFiltersField();
    }

    handleMakeChange(event)
    {
        this.makeChecked = event.target.value;
        this.publishFiltersField();
    }

    handleCategoryChange(event)
    {
        this.categoryChecked = event.target.value;
        this.publishFiltersField();
    }

    handlePriceChange(event)
    {
        this.price = event.target.value;
        this.publishFiltersField();
    }

    publishFiltersField()
    {
        publish(this.messageContext, FILTERS_MESSAGE, {
            category: this.categoryChecked,
            make: this.makeChecked,
            keyWord: this.keyWord, 
            price: this.price
        });
    }
}