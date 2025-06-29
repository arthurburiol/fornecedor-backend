PGDMP      &                }            sis_fornecedor    17.4    17.4 2    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    16719    sis_fornecedor    DATABASE     t   CREATE DATABASE sis_fornecedor WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'pt-BR';
    DROP DATABASE sis_fornecedor;
                     postgres    false            �            1255    16816 @   processar_movimento_estoque(integer, integer, character varying) 	   PROCEDURE     �
  CREATE PROCEDURE public.processar_movimento_estoque(IN p_produto_id integer, IN p_quantidade integer, IN p_tipo_movimento character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_stock INTEGER; -- Variável para armazenar o estoque atual do produto, usada para validações.
BEGIN
    -- 1. Obter o estoque atual do produto.
    --    Essa etapa é crucial para a validação de saída e para garantir que a transação seja consistente.
    SELECT quantidade INTO current_stock
    FROM public.estoque
    WHERE produto_id = p_produto_id;

    -- 2. Lógica Condicional para determinar o tipo de movimentação.
    IF p_tipo_movimento = 'entrada' THEN
        -- **Operação de ENTRADA:**
        -- Atualiza a tabela principal de estoque, somando a quantidade.
        UPDATE public.estoque
        SET
            quantidade = quantidade + p_quantidade, -- Incrementa a quantidade em estoque
            data_atualizacao = CURRENT_TIMESTAMP -- Registra a última atualização
        WHERE produto_id = p_produto_id;

        -- Registra o evento na nova tabela de log.
        INSERT INTO public.log_estoque (produto_id, tipo_movimento, quantidade_movimentada)
        VALUES (p_produto_id, 'entrada', p_quantidade);

    ELSIF p_tipo_movimento = 'saida' THEN
        -- **Operação de SAÍDA:**
        -- Pré-condição: Verificar se há estoque suficiente para a saída.
        IF current_stock >= p_quantidade THEN
            -- Se o estoque for suficiente, prosseguir com a subtração.
            UPDATE public.estoque
            SET
                quantidade = quantidade - p_quantidade, -- Decrementa a quantidade em estoque
                data_atualizacao = CURRENT_TIMESTAMP
            WHERE produto_id = p_produto_id;

            -- Registra o evento na nova tabela de log.
            INSERT INTO public.log_estoque (produto_id, tipo_movimento, quantidade_movimentada)
            VALUES (p_produto_id, 'saida', p_quantidade);
        ELSE
            -- Tratamento de erro: Lançar uma exceção se o estoque for insuficiente.
            RAISE EXCEPTION 'Erro de Negócio: Estoque insuficiente para o produto ID % (Solicitado: %, Disponível: %)',
                            p_produto_id, p_quantidade, current_stock;
        END IF;

    ELSE
        -- Tratamento de erro: Lançar uma exceção para tipo de movimento inválido.
        RAISE EXCEPTION 'Erro de Parâmetro: Tipo de movimento inválido. Utilize ''entrada'' ou ''saida''.';
    END IF;

    -- COMMIT é implícito em chamadas de PROCEDURE, mas explicitado para clareza em ambiente acadêmico.
    COMMIT; -- Confirma as operações de atualização e inserção no banco de dados.

END;
$$;
 �   DROP PROCEDURE public.processar_movimento_estoque(IN p_produto_id integer, IN p_quantidade integer, IN p_tipo_movimento character varying);
       public               postgres    false            �            1259    16720    estoque    TABLE     
  CREATE TABLE public.estoque (
    id integer NOT NULL,
    produto_id integer NOT NULL,
    quantidade integer NOT NULL,
    data_atualizacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT estoque_quantidade_check CHECK ((quantidade >= 0))
);
    DROP TABLE public.estoque;
       public         heap r       postgres    false            �            1259    16725    estoque_id_seq    SEQUENCE     �   CREATE SEQUENCE public.estoque_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.estoque_id_seq;
       public               postgres    false    217                       0    0    estoque_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.estoque_id_seq OWNED BY public.estoque.id;
          public               postgres    false    218            �            1259    16726 
   fornecedor    TABLE     B  CREATE TABLE public.fornecedor (
    id integer NOT NULL,
    cnpj character varying(18) NOT NULL,
    nome character varying(60) NOT NULL,
    email character varying(100) NOT NULL,
    endereco text NOT NULL,
    telefone character varying(20),
    data_cadastro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.fornecedor;
       public         heap r       postgres    false            �            1259    16732    fornecedor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fornecedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.fornecedor_id_seq;
       public               postgres    false    219                       0    0    fornecedor_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.fornecedor_id_seq OWNED BY public.fornecedor.id;
          public               postgres    false    220            �            1259    16796    log_estoque    TABLE     
  CREATE TABLE public.log_estoque (
    id integer NOT NULL,
    produto_id integer NOT NULL,
    tipo_movimento character varying(10) NOT NULL,
    quantidade_movimentada integer NOT NULL,
    data_movimento timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT log_estoque_quantidade_movimentada_check CHECK ((quantidade_movimentada > 0)),
    CONSTRAINT log_estoque_tipo_movimento_check CHECK (((tipo_movimento)::text = ANY ((ARRAY['entrada'::character varying, 'saida'::character varying])::text[])))
);
    DROP TABLE public.log_estoque;
       public         heap r       postgres    false            �            1259    16802    log_estoque_id_seq    SEQUENCE     �   CREATE SEQUENCE public.log_estoque_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.log_estoque_id_seq;
       public               postgres    false    225                       0    0    log_estoque_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.log_estoque_id_seq OWNED BY public.log_estoque.id;
          public               postgres    false    226            �            1259    16733    produto    TABLE     R  CREATE TABLE public.produto (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text NOT NULL,
    categoria character varying(50) NOT NULL,
    valor_unitario numeric(10,2) NOT NULL,
    fornecedor_id integer NOT NULL,
    CONSTRAINT produto_valor_unitario_check CHECK ((valor_unitario > (0)::numeric))
);
    DROP TABLE public.produto;
       public         heap r       postgres    false            �            1259    16739    produto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.produto_id_seq;
       public               postgres    false    221                       0    0    produto_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;
          public               postgres    false    222            �            1259    16811    relatorio_produtos_estoque    VIEW     �  CREATE VIEW public.relatorio_produtos_estoque AS
 SELECT p.id AS produto_id,
    p.nome AS produto_nome,
    p.descricao AS produto_descricao,
    p.categoria AS produto_categoria,
    p.valor_unitario,
    COALESCE(e.quantidade, 0) AS estoque_atual,
    f.nome AS fornecedor_nome,
    f.cnpj AS fornecedor_cnpj,
    f.email AS fornecedor_email
   FROM ((public.produto p
     JOIN public.fornecedor f ON ((p.fornecedor_id = f.id)))
     LEFT JOIN public.estoque e ON ((p.id = e.produto_id)));
 -   DROP VIEW public.relatorio_produtos_estoque;
       public       v       postgres    false    217    221    221    221    221    217    221    221    219    219    219    219            �            1259    16740    usuario    TABLE     �  CREATE TABLE public.usuario (
    id integer NOT NULL,
    cpf character varying(14) NOT NULL,
    nome character varying(60) NOT NULL,
    email character varying(100) NOT NULL,
    senha character varying(255) NOT NULL,
    endereco text NOT NULL,
    telefone character varying(20),
    data_cadastro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    token character varying(255)
);
    DROP TABLE public.usuario;
       public         heap r       postgres    false            �            1259    16746    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public               postgres    false    223                       0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
          public               postgres    false    224            :           2604    16747 
   estoque id    DEFAULT     h   ALTER TABLE ONLY public.estoque ALTER COLUMN id SET DEFAULT nextval('public.estoque_id_seq'::regclass);
 9   ALTER TABLE public.estoque ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217            <           2604    16748    fornecedor id    DEFAULT     n   ALTER TABLE ONLY public.fornecedor ALTER COLUMN id SET DEFAULT nextval('public.fornecedor_id_seq'::regclass);
 <   ALTER TABLE public.fornecedor ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219            A           2604    16803    log_estoque id    DEFAULT     p   ALTER TABLE ONLY public.log_estoque ALTER COLUMN id SET DEFAULT nextval('public.log_estoque_id_seq'::regclass);
 =   ALTER TABLE public.log_estoque ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225            >           2604    16749 
   produto id    DEFAULT     h   ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);
 9   ALTER TABLE public.produto ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            ?           2604    16750 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223            �          0    16720    estoque 
   TABLE DATA           O   COPY public.estoque (id, produto_id, quantidade, data_atualizacao) FROM stdin;
    public               postgres    false    217   �I       �          0    16726 
   fornecedor 
   TABLE DATA           ^   COPY public.fornecedor (id, cnpj, nome, email, endereco, telefone, data_cadastro) FROM stdin;
    public               postgres    false    219   �I       �          0    16796    log_estoque 
   TABLE DATA           m   COPY public.log_estoque (id, produto_id, tipo_movimento, quantidade_movimentada, data_movimento) FROM stdin;
    public               postgres    false    225   �J       �          0    16733    produto 
   TABLE DATA           `   COPY public.produto (id, nome, descricao, categoria, valor_unitario, fornecedor_id) FROM stdin;
    public               postgres    false    221   �J       �          0    16740    usuario 
   TABLE DATA           h   COPY public.usuario (id, cpf, nome, email, senha, endereco, telefone, data_cadastro, token) FROM stdin;
    public               postgres    false    223   AK                  0    0    estoque_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.estoque_id_seq', 2, true);
          public               postgres    false    218                       0    0    fornecedor_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.fornecedor_id_seq', 2, true);
          public               postgres    false    220            	           0    0    log_estoque_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.log_estoque_id_seq', 1, false);
          public               postgres    false    226            
           0    0    produto_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.produto_id_seq', 5, true);
          public               postgres    false    222                       0    0    usuario_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.usuario_id_seq', 1, false);
          public               postgres    false    224            H           2606    16752    estoque estoque_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.estoque DROP CONSTRAINT estoque_pkey;
       public                 postgres    false    217            J           2606    16754    estoque estoque_produto_id_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_produto_id_key UNIQUE (produto_id);
 H   ALTER TABLE ONLY public.estoque DROP CONSTRAINT estoque_produto_id_key;
       public                 postgres    false    217            L           2606    16756    fornecedor fornecedor_cnpj_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key UNIQUE (cnpj);
 H   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key;
       public                 postgres    false    219            N           2606    16758    fornecedor fornecedor_email_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key UNIQUE (email);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key;
       public                 postgres    false    219            P           2606    16760    fornecedor fornecedor_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_pkey;
       public                 postgres    false    219            \           2606    16805    log_estoque log_estoque_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.log_estoque
    ADD CONSTRAINT log_estoque_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.log_estoque DROP CONSTRAINT log_estoque_pkey;
       public                 postgres    false    225            R           2606    16762 &   produto produto_nome_fornecedor_id_key 
   CONSTRAINT     p   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_nome_fornecedor_id_key UNIQUE (nome, fornecedor_id);
 P   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_nome_fornecedor_id_key;
       public                 postgres    false    221    221            T           2606    16764    produto produto_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public                 postgres    false    221            V           2606    16766    usuario usuario_cpf_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key UNIQUE (cpf);
 A   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_cpf_key;
       public                 postgres    false    223            X           2606    16768    usuario usuario_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key;
       public                 postgres    false    223            Z           2606    16770    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public                 postgres    false    223            ]           2606    16771    estoque estoque_produto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produto(id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.estoque DROP CONSTRAINT estoque_produto_id_fkey;
       public               postgres    false    4692    221    217            _           2606    16806 '   log_estoque log_estoque_produto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.log_estoque
    ADD CONSTRAINT log_estoque_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produto(id) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.log_estoque DROP CONSTRAINT log_estoque_produto_id_fkey;
       public               postgres    false    4692    221    225            ^           2606    16776 "   produto produto_fornecedor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_fornecedor_id_fkey FOREIGN KEY (fornecedor_id) REFERENCES public.fornecedor(id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_fornecedor_id_fkey;
       public               postgres    false    221    4688    219            �      x������ � �      �   �   x�E�1n1��z|
�P��� y+�^ -�q�bi�F*��r�l�E��o>=�D�L;�a �,��27Hm�s*q<�քK���6O�V;|�[N�O{`#a�=s�ˀk��;��{�UQ�(�a��WT<c���+õ�X�?vHk{��V���1?"lT�6��)��ɺE�~���7g4����>"      �      x������ � �      �   �   x�U���@D뽯�^B��C[P��]aa�
"��q~���hlf&�̛5�}������C����'ܡ����ufȝ��6�HrZ{�!���l�(%�6Ќ�bc���X���Wx�I�Ff���ʀ+�+�T�[��zǬ/�      �   �  x�e�Kn�0�5}�Y��D���Wu����FRt��Dbk�hP���:]����2T�&AwC���J&UƵ�yQV��l�/�<ܺ���GχX���Z�k߱��{�m{��a7G�x��`�hR��~>��x���gK)�@U�Iu�$SBete*H���Jvw�P����hN�R��'�s�N�d]r?_��q8��E3o}��kv���;`� M�p�pXw���՘����X�bO��UE+=E�&/�٪R%@j��֌I)�R�g�glg�@����!�|��+e�8))�Y�%��CL��:'@Sd��Z�k"��m=|���}?Z��"0��Js�<AT+if�fZkn��y��B�u���È{$U�p=]6��~�񻁂%Z�F	J!�<��H`snt�Ȗ:¨�:���0� �~�V/˒W}<�6Z?�Ά���4䇿���_㾹ڵ?�/Z�bg'� �?��v��7�|=�[�=P�&Jcz���z�	R>���/�G��"     