({
    wordsGridHandler: function (cmp, event, helper)
    {
        let clickedWord = event.getParam("clickedWord");
        let hiddenWord = cmp.get("v.hiddenWord");
        let countClick = parseInt(cmp.get("v.moves")) - 1;

        if(countClick >= 0) { cmp.set("v.moves", countClick); }

        if(clickedWord === hiddenWord)
        {
            helper.createToast("You Win!", "Congratulations!", "success");
            helper.fireEvent(cmp, true);
        }
        else if(countClick === 0)
        {
            helper.createToast("You Lose!", "Good luck next time.", "error");
            cmp.set("v.moves", 0);
            helper.fireEvent(cmp, false);
        }
    }
});