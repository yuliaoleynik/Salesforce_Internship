({
    wordClickHandler: function (cmp, event)
    {
        cmp.set("v.isOpened", true);
        let wordText = cmp.get("v.text");

        let cmpEvent = cmp.getEvent("onclick");
        cmpEvent.setParams({"clickedWord": wordText});
        cmpEvent.fire();
    }
});