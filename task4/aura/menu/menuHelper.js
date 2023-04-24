({
    LABELS: ["judge", "established", "loot", "discourage", "arise", "possibility", "reflection", "loss", "ethics",
        "version", "morsel", "pursuit", "due", "conversation", "goalkeeper", "iron", "coffin", "crackpot", "sensitivity",
        "value", "action", "handy", "church", "ethnic", "withdrawal", "pleasant", "hot", "accept", "compact", "precede",
        "pupil", "senior", "flash", "carry", "hour", "ladder"],

    toInitial: function (cmp, event)
    {
        let labels = cmp.get("v.wordsLabels");
        let size = cmp.get("v.layoutSize");

        let arrWords = [];
        for(let i = 0; i < (+size); i++)
        {
            arrWords.push({isOpened: false, text: labels[i]});
        }

        cmp.set("v.words", arrWords);
        cmp.set("v.moves", 3);

        this.disableWordsGridClickAbility(cmp, event, false);
        this.chooseHiddenWord(cmp, labels, +size);
    },

    reshuffle: function (cmp)
    {
        let arrWords = cmp.get("v.words");

        for (let i = arrWords.length - 1; i > 0; i--)
        {
            let j = Math.floor(Math.random() * (i + 1));
            arrWords[i] = [arrWords[j], arrWords[j] = arrWords[i]][0];
        }

        cmp.set("v.words", arrWords);
        cmp.set("v.moves", 3);
    },

    disableReshuffleButtonClick: function (cmp, value)
    {
        let button = cmp.find("reshuffleId");
        button.set('v.disabled',value);
    },

    disableWordsGridClickAbility: function (cmp, event, value)
    {
        let cmpTarget = cmp.find("wordsGridId");
        if(value === false)
        {
            $A.util.removeClass(cmpTarget, 'change');
        }
        else
        {
            $A.util.addClass(cmpTarget, 'change');
        }
    },

    chooseHiddenWord: function (cmp, texts, size)
    {
        cmp.set("v.hiddenWord", texts[Math.floor(Math.random() * (+size))]);
    }
});