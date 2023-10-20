local Translations = {
    error = {
        not_enough = "Du har ikke nok kontanter...",
        no_slots = "Der er ingen ledige pladser tilbage",
        occured = "Der opstod en fejl",
        have_keys = "Denne person har allerede nøgler",
        p_have_keys = "%{value} Denne person har allerede nøgler",
        not_owner = "Du ejer ikke et traphouse eller er ikke ejeren",
        not_online = "Denne person er ikke i byen",
        no_money = "Der er ingen penge i skabet",
        incorrect_code = "Denne kode er forkert",
        up_to_6 = "Du kan give op til 6 personer adgang til traphouse!",
        cancelled = "Opkøb annulleret",
    },
    success = {
        added = "%{value} er blevet tilføjet til traphouse!",
    },
    info = {
        enter = "Gå ind i traphouse",
        give_keys = "Giv nøgler til traphouse",
        pincode = "Traphouse Pinkode: %{value}",
        taking_over = "Overtager",
        pin_code_see = "~b~G~w~ - Se pinkode",
        pin_code = "Pinkode: %{value}",
        multikeys = "~b~/multikeys~w~ [id] - Til at give nøgler",
        take_cash = "~b~E~w~ - Tag kontanter (~g~$%{value}~w~)",
        inventory = "~b~H~w~ - Se lager",
        take_over = "~b~E~w~ - Overtag (~g~$5000~w~)",
        leave = "~b~E~w~ - Forlad traphouse",
    },
    targetInfo = {
        options = "Traphouse muligheder",
        enter = "Gå ind i traphouse",
        give_keys = "Giv nøgler til traphouse",
        pincode = "Traphouse Pinkode: %{value}",
        taking_over = "Overtager",
        pin_code_see = "Se pinkode",
        pin_code = "Pinkode: %{value}",
        multikeys = "Giv nøgler (brug /multikey [id])",
        take_cash = "Tag kontanter ($%{value})",
        inventory = "Se lager",
        take_over = "Overtag ($5000)",
        leave = "Forlad traphouse",
        close_menu = "⬅ Luk menu",
    }
}


if GetConvar('qb_locale', 'en') == 'da' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end