-- Script de Criação do Banco de Dados DPM para PostgreSQL

-- Tabela Usuarios
CREATE TABLE Usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    ultima_atualizacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela DispositivosInteligentes
CREATE TABLE DispositivosInteligentes (
    id_dispositivo SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    identificador_dispositivo VARCHAR(255) UNIQUE NOT NULL,
    nome_personalizado VARCHAR(100),
    status_conexao BOOLEAN DEFAULT FALSE,
    data_adicao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    ultima_atualizacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Eletrodomesticos
CREATE TABLE Eletrodomesticos (
    id_eletrodomestico SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_dispositivo_inteligente INTEGER REFERENCES DispositivosInteligentes(id_dispositivo) ON DELETE SET NULL,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(100),
    marca VARCHAR(100),
    modelo VARCHAR(100),
    potencia_estimada_watts NUMERIC(10, 2),
    data_cadastro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    ultima_atualizacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_usuario_eletrodomestico_nome UNIQUE (id_usuario, nome) -- Um usuário não pode ter dois eletrodomésticos com o mesmo nome
);

-- Tabela MedicoesConsumo
CREATE TABLE MedicoesConsumo (
    id_medicao BIGSERIAL PRIMARY KEY,
    id_eletrodomestico INTEGER NOT NULL REFERENCES Eletrodomesticos(id_eletrodomestico) ON DELETE CASCADE,
    timestamp_medicao TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    consumo_kwh NUMERIC(10, 4) NOT NULL,
    corrente_amperes NUMERIC(10, 4),
    tensao_volts NUMERIC(10, 2),
    potencia_watts NUMERIC(10, 2)
);

-- Tabela Alertas
CREATE TABLE Alertas (
    id_alerta SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_eletrodomestico INTEGER REFERENCES Eletrodomesticos(id_eletrodomestico) ON DELETE CASCADE,
    tipo_alerta VARCHAR(100) NOT NULL, -- Ex: "Consumo Excessivo", "Uso Prolongado Inativo", "Anomalia IA"
    mensagem TEXT NOT NULL,
    timestamp_geracao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    lido BOOLEAN DEFAULT FALSE,
    data_leitura TIMESTAMP WITH TIME ZONE
);

-- Tabela SugestoesEconomia
CREATE TABLE SugestoesEconomia (
    id_sugestao SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_eletrodomestico INTEGER REFERENCES Eletrodomesticos(id_eletrodomestico) ON DELETE SET NULL,
    descricao_sugestao TEXT NOT NULL,
    data_geracao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    aplicada BOOLEAN
);

-- Tabela PrevisoesConsumo
CREATE TABLE PrevisoesConsumo (
    id_previsao SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    id_eletrodomestico INTEGER REFERENCES Eletrodomesticos(id_eletrodomestico) ON DELETE CASCADE, -- Pode ser geral ou por aparelho
    data_previsao_inicio TIMESTAMP WITH TIME ZONE NOT NULL,
    data_previsao_fim TIMESTAMP WITH TIME ZONE NOT NULL,
    consumo_previsto_kwh NUMERIC(10, 4) NOT NULL,
    algoritmo_utilizado VARCHAR(100),
    data_geracao_previsao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Índices para otimização de consultas
CREATE INDEX idx_dispositivos_usuario ON DispositivosInteligentes(id_usuario);
CREATE INDEX idx_eletrodomesticos_usuario ON Eletrodomesticos(id_usuario);
CREATE INDEX idx_eletrodomesticos_dispositivo ON Eletrodomesticos(id_dispositivo_inteligente);
CREATE INDEX idx_medicoes_eletrodomestico_timestamp ON MedicoesConsumo(id_eletrodomestico, timestamp_medicao DESC);
CREATE INDEX idx_alertas_usuario ON Alertas(id_usuario);
CREATE INDEX idx_alertas_eletrodomestico ON Alertas(id_eletrodomestico);
CREATE INDEX idx_sugestoes_usuario ON SugestoesEconomia(id_usuario);
CREATE INDEX idx_previsoes_usuario ON PrevisoesConsumo(id_usuario);
CREATE INDEX idx_previsoes_eletrodomestico ON PrevisoesConsumo(id_eletrodomestico);

-- Funções para atualizar 'ultima_atualizacao' automaticamente (Opcional, mas recomendado)
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.ultima_atualizacao = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers para Usuarios
CREATE TRIGGER set_timestamp_usuarios
BEFORE UPDATE ON Usuarios
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Triggers para DispositivosInteligentes
CREATE TRIGGER set_timestamp_dispositivos
BEFORE UPDATE ON DispositivosInteligentes
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Triggers para Eletrodomesticos
CREATE TRIGGER set_timestamp_eletrodomesticos
BEFORE UPDATE ON Eletrodomesticos
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

COMMENT ON TABLE Usuarios IS 'Armazena informações dos usuários do aplicativo.';
COMMENT ON COLUMN Usuarios.senha_hash IS 'Hash da senha do usuário, nunca a senha em texto plano.';
COMMENT ON TABLE DispositivosInteligentes IS 'Representa as tomadas inteligentes ou outros dispositivos de monitoramento.';
COMMENT ON COLUMN DispositivosInteligentes.identificador_dispositivo IS 'ID único do hardware do dispositivo (ex: MAC Address).';
COMMENT ON TABLE Eletrodomesticos IS 'Cadastro dos eletrodomésticos monitorados pelos usuários.';
COMMENT ON COLUMN Eletrodomesticos.potencia_estimada_watts IS 'Potência nominal do aparelho, usada para estimativas e cadastros.';
COMMENT ON TABLE MedicoesConsumo IS 'Registros de consumo de energia dos eletrodomésticos.';
COMMENT ON COLUMN MedicoesConsumo.consumo_kwh IS 'Consumo de energia em kilowatt-hora.';
COMMENT ON TABLE Alertas IS 'Notificações e alertas gerados para os usuários.';
COMMENT ON TABLE SugestoesEconomia IS 'Sugestões personalizadas para economia de energia.';
COMMENT ON TABLE PrevisoesConsumo IS 'Previsões de consumo de energia geradas pela IA.';

-- Exemplo de inserção de dados (opcional, para teste)
/*
INSERT INTO Usuarios (nome, email, senha_hash) VALUES
('Usuário Teste', 'teste@example.com', 'hash_seguro_da_senha');

INSERT INTO DispositivosInteligentes (id_usuario, identificador_dispositivo, nome_personalizado) VALUES
(1, 'MAC_ADDRESS_TOMADA_1', 'Tomada da Sala');

INSERT INTO Eletrodomesticos (id_usuario, id_dispositivo_inteligente, nome, categoria, potencia_estimada_watts) VALUES
(1, 1, 'TV da Sala', 'Eletrônicos', 150);

INSERT INTO MedicoesConsumo (id_eletrodomestico, consumo_kwh, potencia_watts) VALUES
(1, 0.15, 150);
*/

SELECT 'Script de criação do banco de dados DPM executado com sucesso!' AS status;
