({
    createToast: function (title, message, type)
    {
        let toast = $A.get("e.force:showToast");
        toast.setParams({
            "title": title,
            "message": message,
            "type": type
        });
        toast.fire();
    },

    fireEvent: function (cmp, value)
    {
        let cmpEvent = cmp.getEvent("gameResult");
        cmpEvent.setParams({"result": value});
        cmpEvent.fire();
    }
});