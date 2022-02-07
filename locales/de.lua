local Translations = {
    error = {
        not_enough = "Du hast nicht genug Bargeld..",
        no_slots = "Es sind keine Slots mehr übrig",
        occured = "Es ist ein Fehler aufgetreten",
        have_keys = "Diese Person hat bereits Schlüssel",
        p_have_keys = "%{value} Diese Person hat bereits Schlüssel",
        not_owner = "Du besitzt kein Traphouse oder sind nicht der Eigentümer",
        not_online = "Die Person ist nicht in der Stadt",
        no_money = "Es ist kein Geld im Schrank",
        incorrect_code = "Der Code ist nicht korrekt",
        up_to_6 = "Sie können bis zu 6 Personen Zugang zum Traphouse geben!",
        cancelled = "Annulliere Übernahme",
    },
    success = {
        added = "%{value} Wurde dem Traphouse hinzugefügt!",
    },
    info = {
        enter = "Traphouse betreten",
        give_keys = "Gebe die Schlüssel vom Traphouse",
        pincode = "Traphouse Pincode: %{value}",
        taking_over = "Übernehmen",
        pin_code_see = "~b~G~w~ - Pincode",
        pin_code = "Pincode: %{value}",
        multikeys = "~b~/multikeys~w~ [id] - Schlüssel geben",
        take_cash = "~b~E~w~ - Geld nehmen (~g~$%{value}~w~)",
        inventory = "~b~H~w~ - Inventar",
        take_over = "~b~E~w~ - Übernehmen (~g~$5000~w~)",
        leave = "~b~E~w~ - Verlassen",
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true
    })    
end

