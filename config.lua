Config = Config or {}
Config.Auth = Config.Auth or {}
Config.Auth.Token = Config.Auth.Token or "SUA CHAVE KEY AQUI"

--[[
	qz_roupa - CONFIG

	Como funciona (resumo):
	- Você define "Outfits" (roupas) em Config.Outfits.
	- Você define quais outfits cada grupo/cargo pode ver em Config.Groups.
	- O script identifica o grupo/hierarquia do player pelo vRP e:
	  - Mostra no menu apenas os outfits liberados
	  - Só permite aplicar outfits liberados
	- Cada grupo pode ter locais (CDS) para abrir o painel: chegando perto, aperta E.

	Dica:
	- Use o comando de exportação (Config.ExportCommand) pra gerar um bloco pronto
	  da roupa atual e colar aqui em Config.Outfits.
--]]

-- Comando para abrir o menu manualmente.
-- Restrição: somente Admin consegue usar este comando.
Config.Command = "roupas"

Config.Debug = false

Config.ClearPropsOnApply = false
Config.ClearPropsIds = { 0, 1, 2, 3, 4, 5, 6, 7 }

-- Comando que imprime no F8 a roupa atual no formato do Config.Outfits.
-- Restrição: somente Admin consegue usar este comando.
-- Uso: /roupasexport (ou o nome que você colocar aqui)
Config.ExportCommand = "roupasexport"

-- Configuração do marcador/área de interação dos locais (CDS).
Config.Marker = {
	-- Distância máxima para desenhar o marcador.
	drawDistance = 15.0,
	-- Distância para aparecer o texto "Pressione E" e permitir abrir.
	interactDistance = 1.5
}

-- Prioridade para escolher qual "grupo principal" usar quando o player tem mais de um.
-- Exemplo: se o player tem Admin e Policia, ele cai primeiro no Admin.
Config.GroupPriority = {
	"Admin",
	"Policia",
	"hp",
	"Paramedico"
}

-- Configuração por grupo.
-- A key do grupo aqui precisa ser o nome do grupo no seu vRP (ex.: "Policia", "Admin", etc.)
Config.Groups = {
	-- Grupo padrão (fallback) quando o player não encaixa em nenhum acima.
	default = {
		-- Lista de outfits liberados (as keys precisam existir em Config.Outfits).
		outfits = { "medico", "Diretor" },
		-- Locais (CDS) onde esse grupo consegue abrir o painel apertando E.
		-- Formatos aceitos:
		-- 1) Tabela: { x = 433.42, y = -993.08, z = 30.7 }
		-- 2) String: "433.42,-993.08,30.7"
		locations = {
			{ x = 0.0, y = 0.0, z = 0.0 }
		}
	},

	Policia = {
		-- Locais do painel para a polícia.
		locations = {
			"-00.0,00.0,00.0"
		},

		-- Roupas por hierarquia/cargo (vRP).
		-- Importante: no vRP, normalmente "1" é o cargo mais alto, e números maiores são cargos mais baixos.
		-- Regra do script:
		-- - Se o player estiver no nível 10, ele vê só as roupas do 10.
		-- - Se o player estiver no nível 9, ele vê as roupas do 9 e também do 10.
		--   (ou seja: ele herda níveis maiores/iguais ao dele)
		--
		-- Como editar:
		-- - Crie [n] = { outfits = { "key1", "key2" } }
		-- - As keys precisam existir em Config.Outfits
		ranks = {
			[10] = { outfits = { "miner" } },
			[9] = { outfits = { "medico" } }
		}
	},
		Paramedico = {
		-- Locais do painel para a polícia.
		locations = {
			"413.6,-985.26,29.42"
		},

		-- Roupas por hierarquia/cargo (vRP).
		-- Importante: no vRP, normalmente "1" é o cargo mais alto, e números maiores são cargos mais baixos.
		-- Regra do script:
		-- - Se o player estiver no nível 10, ele vê só as roupas do 10.
		-- - Se o player estiver no nível 9, ele vê as roupas do 9 e também do 10.
		--   (ou seja: ele herda níveis maiores/iguais ao dele)
		--
		-- Como editar:
		-- - Crie [n] = { outfits = { "key1", "key2" } }
		-- - As keys precisam existir em Config.Outfits
		ranks = {
			[2] = { outfits = { "medico" } },
			[1] = { outfits = { "Diretor" } },
			[15] = { outfits = { "t2" } }
		}
	}
}



-- Definição das roupas.
-- A key (ex.: "fisherman") é o identificador usado:
-- - No botão da NUI (data-outfit="fisherman")
-- - Em Config.Groups.<grupo>.outfits / ranks[n].outfits
Config.Outfits = {
	medico = {
		-- Imagem do card na NUI (arquivo local).
		-- Coloque a imagem dentro da pasta: qz_roupa/imagens/
		-- Ex.: imagens/fisherman.png
		image = "imagens/doutor.png",

		-- Configuração de roupa para personagem masculino (mp_m_freemode_01).
		male = {
			-- Components (partes de roupa do ped):
			-- id = "componentId" do GTA (0 a 11)
			-- drawable = modelo
			-- texture = textura do modelo
			-- palette = paleta
			--
			-- Como editar:
			-- - Você pode usar /roupaexport pra gerar isso automaticamente.
			-- - Depois ajuste drawable/texture/palette conforme quiser.
			components = {
				{ id = 0, drawable = 0, texture = 0, palette = 0 },
				{ id = 1, drawable = 121, texture = 0, palette = 0 },
				{ id = 2, drawable = 3, texture = 0, palette = 0 },
				{ id = 3, drawable = 19, texture = 0, palette = 0 },
				{ id = 4, drawable = 25, texture = 5, palette = 0 },
				{ id = 5, drawable = 0, texture = 0, palette = 0 },
				{ id = 6, drawable = 103, texture = 4, palette = 0 },
				{ id = 7, drawable = 0, texture = 0, palette = 0 },
				{ id = 8, drawable = 21, texture = 0, palette = 0 },
				{ id = 9, drawable = 0, texture = 0, palette = 0 },
				{ id = 10, drawable = 0, texture = 0, palette = 0 },
				{ id = 11, drawable = 590, texture = 2, palette = 0 }
			},

			-- Props (acessórios como boné/óculos/etc):
			-- id = propId (0 a 7)
			-- drawable = -1 remove o prop, >=0 aplica
			-- texture = textura do prop
			props = {
				{ id = 0, drawable = -1, texture = 0 },
				{ id = 1, drawable = 15, texture = 1 },
				{ id = 2, drawable = -1, texture = 0 },
				{ id = 3, drawable = -1, texture = 0 },
				{ id = 4, drawable = -1, texture = 0 },
				{ id = 5, drawable = -1, texture = 0 },
				{ id = 6, drawable = -1, texture = 0 },
				{ id = 7, drawable = -1, texture = 0 }
			}
		},

		-- Configuração de roupa para personagem feminino (mp_f_freemode_01).
		female = {
			-- Mesma lógica do male.
			components = {
				{ id = 11, drawable = 59, texture = 0, palette = 0 },
				{ id = 8, drawable = 14, texture = 0, palette = 0 },
				{ id = 4, drawable = 38, texture = 0, palette = 0 },
				{ id = 6, drawable = 25, texture = 0, palette = 0 },
				{ id = 3, drawable = 14, texture = 0, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 }
			}
		}
	},
		Diretor = {
		-- Imagem do card na NUI (arquivo local).
		-- Coloque a imagem dentro da pasta: qz_roupa/imagens/
		-- Ex.: imagens/fisherman.png
		image = "imagens/diretor.png",

		-- Configuração de roupa para personagem masculino (mp_m_freemode_01).
		male = {
			components = {
				{ id = 0, drawable = 0, texture = 0, palette = 0 },
				{ id = 1, drawable = 121, texture = 0, palette = 0 },
				{ id = 2, drawable = 3, texture = 0, palette = 0 },
				{ id = 3, drawable = 19, texture = 0, palette = 0 },
				{ id = 4, drawable = 25, texture = 5, palette = 0 },
				{ id = 5, drawable = 0, texture = 0, palette = 0 },
				{ id = 6, drawable = 103, texture = 4, palette = 0 },
				{ id = 7, drawable = 0, texture = 0, palette = 0 },
				{ id = 8, drawable = 21, texture = 0, palette = 0 },
				{ id = 9, drawable = 0, texture = 0, palette = 0 },
				{ id = 10, drawable = 0, texture = 0, palette = 0 },
				{ id = 11, drawable = 590, texture = 2, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 },
				{ id = 1, drawable = 15, texture = 1 },
				{ id = 2, drawable = -1, texture = 0 },
				{ id = 3, drawable = -1, texture = 0 },
				{ id = 4, drawable = -1, texture = 0 },
				{ id = 5, drawable = -1, texture = 0 },
				{ id = 6, drawable = -1, texture = 0 },
				{ id = 7, drawable = -1, texture = 0 }
			}
		},

		-- Configuração de roupa para personagem feminino (mp_f_freemode_01).
		female = {
			-- Mesma lógica do male.
			components = {
				{ id = 11, drawable = 59, texture = 0, palette = 0 },
				{ id = 8, drawable = 14, texture = 0, palette = 0 },
				{ id = 4, drawable = 38, texture = 0, palette = 0 },
				{ id = 6, drawable = 25, texture = 0, palette = 0 },
				{ id = 3, drawable = 14, texture = 0, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 }
			}
		}
	},
			t2 = {
		-- Imagem do card na NUI (arquivo local).
		-- Coloque a imagem dentro da pasta: qz_roupa/imagens/
		-- Ex.: imagens/fisherman.png
		image = "imagens/diretor.png",

		-- Configuração de roupa para personagem masculino (mp_m_freemode_01).
		male = {
			components = {
				{ id = 0, drawable = 0, texture = 0, palette = 0 },
				{ id = 1, drawable = 121, texture = 0, palette = 0 },
				{ id = 2, drawable = 3, texture = 0, palette = 0 },
				{ id = 3, drawable = 19, texture = 0, palette = 0 },
				{ id = 4, drawable = 25, texture = 5, palette = 0 },
				{ id = 5, drawable = 0, texture = 0, palette = 0 },
				{ id = 6, drawable = 103, texture = 4, palette = 0 },
				{ id = 7, drawable = 0, texture = 0, palette = 0 },
				{ id = 8, drawable = 21, texture = 0, palette = 0 },
				{ id = 9, drawable = 0, texture = 0, palette = 0 },
				{ id = 10, drawable = 0, texture = 0, palette = 0 },
				{ id = 11, drawable = 590, texture = 2, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 },
				{ id = 1, drawable = 15, texture = 1 },
				{ id = 2, drawable = -1, texture = 0 },
				{ id = 3, drawable = -1, texture = 0 },
				{ id = 4, drawable = -1, texture = 0 },
				{ id = 5, drawable = -1, texture = 0 },
				{ id = 6, drawable = -1, texture = 0 },
				{ id = 7, drawable = -1, texture = 0 }
			}
		},

		-- Configuração de roupa para personagem feminino (mp_f_freemode_01).
		female = {
			-- Mesma lógica do male.
			components = {
				{ id = 11, drawable = 59, texture = 0, palette = 0 },
				{ id = 8, drawable = 14, texture = 0, palette = 0 },
				{ id = 4, drawable = 38, texture = 0, palette = 0 },
				{ id = 6, drawable = 25, texture = 0, palette = 0 },
				{ id = 3, drawable = 14, texture = 0, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 }
			}
		}
	},
	miner = {
		image = "imagens/miner.png",
		male = {
			components = {
				{ id = 11, drawable = 16, texture = 0, palette = 0 },
				{ id = 8, drawable = 15, texture = 0, palette = 0 },
				{ id = 4, drawable = 36, texture = 0, palette = 0 },
				{ id = 6, drawable = 24, texture = 0, palette = 0 },
				{ id = 3, drawable = 4, texture = 0, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 }
			}
		},
		female = {
			components = {
				{ id = 11, drawable = 16, texture = 0, palette = 0 },
				{ id = 8, drawable = 14, texture = 0, palette = 0 },
				{ id = 4, drawable = 35, texture = 0, palette = 0 },
				{ id = 6, drawable = 24, texture = 0, palette = 0 },
				{ id = 3, drawable = 5, texture = 0, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 }
			}
		}
	},
	logistics = {
		image = "imagens/logistics.png",
		male = {
			components = {
				{ id = 11, drawable = 13, texture = 0, palette = 0 },
				{ id = 8, drawable = 15, texture = 0, palette = 0 },
				{ id = 4, drawable = 35, texture = 0, palette = 0 },
				{ id = 6, drawable = 34, texture = 0, palette = 0 },
				{ id = 3, drawable = 0, texture = 0, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 }
			}
		},
		female = {
			components = {
				{ id = 11, drawable = 13, texture = 0, palette = 0 },
				{ id = 8, drawable = 14, texture = 0, palette = 0 },
				{ id = 4, drawable = 34, texture = 0, palette = 0 },
				{ id = 6, drawable = 34, texture = 0, palette = 0 },
				{ id = 3, drawable = 14, texture = 0, palette = 0 }
			},
			props = {
				{ id = 0, drawable = -1, texture = 0 }
			}
		}
	}
}
