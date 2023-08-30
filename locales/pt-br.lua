local Translations = {
    error = {
        not_enough = "Você não tem dinheiro suficiente..",
        no_slots = "Não há mais vagas disponíveis",
        occured = "Ocorreu um erro",
        have_keys = "Essa pessoa já possui chaves",
        p_have_keys = "%{value} Essa pessoa já possui chaves",
        not_owner = "Você não possui uma casa de armadilha ou não é o proprietário",
        not_online = "Essa pessoa não está na cidade",
        no_money = "Não há dinheiro no armário",
        incorrect_code = "Este código está incorreto",
        up_to_6 = "Você pode dar acesso a até 6 pessoas à casa de armadilha!",
        cancelled = "Aquisições canceladas",
    },
    success = {
        added = "%{value} foi adicionado à casa de armadilha!",
    },
    info = {
        enter = "Entrar na casa de armadilha",
        give_keys = "Dar chaves da casa de armadilha",
        pincode = "Código PIN da casa de armadilha: %{value}",
        taking_over = "Assumindo o controle",
        pin_code_see = "~b~G~w~ - Ver Código PIN",
        pin_code = "Código PIN: %{value}",
        multikeys = "~b~/multikeys~w~ [id] - Para dar chaves",
        take_cash = "~b~E~w~ - Pegar dinheiro (~g~$%{value}~w~)",
        inventory = "~b~H~w~ - Ver Inventário",
        take_over = "~b~E~w~ - Assumir o controle (~g~$5000~w~)",
        leave = "~b~E~w~ - Sair da casa de armadilha",
    },
    targetInfo = {
        options = "Opções da Casa de Armadilha",
        enter = "Entrar na casa de armadilha",
        give_keys = "Dar chaves da casa de armadilha",
        pincode = "Código PIN da casa de armadilha: %{value}",
        taking_over = "Assumindo o controle",
        pin_code_see = "Ver Código PIN",
        pin_code = "Código PIN: %{value}",
        multikeys = "Dar chaves (use /multikey [id])",
        take_cash = "Pegar dinheiro ($%{value})",
        inventory = "Ver Inventário",
        take_over = "Assumir o controle ($5000)",
        leave = "Sair da casa de armadilha",
        close_menu = "⬅ Fechar Menu",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
