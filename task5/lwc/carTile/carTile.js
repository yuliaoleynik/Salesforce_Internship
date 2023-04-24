import {LightningElement, api} from 'lwc';

export default class CarTile extends LightningElement
{
    _car;
    pictureUrl;
    name;
    msrp;

    @api
    get car()
    {
        return this._car;
    }
    set car(value)
    {
        this._car = value;
        this.pictureUrl = value.Picture_URL__c;
        this.name = value.Name;
        this.msrp = value.MSRP__c;
    }

    handleClick()
    {
        const selectedEvent = new CustomEvent('selected', {
            detail: this.car.Id
        });
        this.dispatchEvent(selectedEvent);
    }
}