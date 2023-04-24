({
    doInit: function (cmp, event, helper)
    {
        cmp.set("v.wordsLabels", helper.LABELS);
    },

    handleChange: function (cmp, event, helper)
    {
        let selectedMode = event.getParam("value");

        cmp.set("v.layoutSize", selectedMode);
        cmp.set("v.displayWordsGrid", true);

        helper.toInitial(cmp, event);
    },

    handleStart : function (cmp, event, helper)
    {
        helper.toInitial(cmp, event);
        helper.disableReshuffleButtonClick(cmp, true);
    },

    handleReshuffle: function (cmp, event, helper)
    {
        helper.reshuffle(cmp);
        helper.disableWordsGridClickAbility(cmp, event, false);
    },

    gameResultHandler : function (cmp, event, helper)
    {
        let result = event.getParam("result");
        if (result === false)
        {
            helper.disableReshuffleButtonClick(cmp, false);
        }
        else
        {
            helper.disableReshuffleButtonClick(cmp, true);
        }

        helper.disableWordsGridClickAbility(cmp, event, true);
    }
});