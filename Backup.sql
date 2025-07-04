PGDMP      ,                }            sis_fornecedor #   17.5 (Ubuntu 17.5-0ubuntu0.25.04.1) #   17.5 (Ubuntu 17.5-0ubuntu0.25.04.1) <    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    32829    sis_fornecedor    DATABASE     z   CREATE DATABASE sis_fornecedor WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'pt_BR.UTF-8';
    DROP DATABASE sis_fornecedor;
                     postgres    false            �            1259    32831    estoque    TABLE     �   CREATE TABLE public.estoque (
    id integer NOT NULL,
    produto_id integer NOT NULL,
    quantidade integer NOT NULL,
    data_atualizacao timestamp with time zone
);
    DROP TABLE public.estoque;
       public         heap r       postgres    false            �            1259    32830    estoque_id_seq    SEQUENCE     �   CREATE SEQUENCE public.estoque_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.estoque_id_seq;
       public               postgres    false    218            �           0    0    estoque_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.estoque_id_seq OWNED BY public.estoque.id;
          public               postgres    false    217            �            1259    32838 
   fornecedor    TABLE     %  CREATE TABLE public.fornecedor (
    id integer NOT NULL,
    cnpj character varying(18) NOT NULL,
    nome character varying(60) NOT NULL,
    email character varying(100) NOT NULL,
    endereco text NOT NULL,
    telefone character varying(20),
    data_cadastro timestamp with time zone
);
    DROP TABLE public.fornecedor;
       public         heap r       postgres    false            �            1259    32837    fornecedor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fornecedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.fornecedor_id_seq;
       public               postgres    false    220            �           0    0    fornecedor_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.fornecedor_id_seq OWNED BY public.fornecedor.id;
          public               postgres    false    219            �            1259    32851    produto    TABLE       CREATE TABLE public.produto (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text NOT NULL,
    categoria character varying(50) NOT NULL,
    valor_unitario numeric(10,2) NOT NULL,
    fornecedor_id integer NOT NULL,
    peso_unitario numeric(10,2)
);
    DROP TABLE public.produto;
       public         heap r       postgres    false            �            1259    32850    produto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.produto_id_seq;
       public               postgres    false    222            �           0    0    produto_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;
          public               postgres    false    221            �            1259    49442    usuario    TABLE     e  CREATE TABLE public.usuario (
    id integer NOT NULL,
    cpf character varying(14) NOT NULL,
    nome character varying(60) NOT NULL,
    email character varying(100) NOT NULL,
    senha character varying(255),
    endereco text NOT NULL,
    telefone character varying(20),
    data_cadastro timestamp with time zone,
    token character varying(100)
);
    DROP TABLE public.usuario;
       public         heap r       postgres    false            �            1259    49441    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public               postgres    false    224            �           0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
          public               postgres    false    223            �           2604    32834 
   estoque id    DEFAULT     h   ALTER TABLE ONLY public.estoque ALTER COLUMN id SET DEFAULT nextval('public.estoque_id_seq'::regclass);
 9   ALTER TABLE public.estoque ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            �           2604    32841    fornecedor id    DEFAULT     n   ALTER TABLE ONLY public.fornecedor ALTER COLUMN id SET DEFAULT nextval('public.fornecedor_id_seq'::regclass);
 <   ALTER TABLE public.fornecedor ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    220    220            �           2604    32854 
   produto id    DEFAULT     h   ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);
 9   ALTER TABLE public.produto ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221    222            �           2604    49445 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    224    224            �          0    32831    estoque 
   TABLE DATA           O   COPY public.estoque (id, produto_id, quantidade, data_atualizacao) FROM stdin;
    public               postgres    false    218   �H       �          0    32838 
   fornecedor 
   TABLE DATA           ^   COPY public.fornecedor (id, cnpj, nome, email, endereco, telefone, data_cadastro) FROM stdin;
    public               postgres    false    220   �H       �          0    32851    produto 
   TABLE DATA           o   COPY public.produto (id, nome, descricao, categoria, valor_unitario, fornecedor_id, peso_unitario) FROM stdin;
    public               postgres    false    222   VI       �          0    49442    usuario 
   TABLE DATA           h   COPY public.usuario (id, cpf, nome, email, senha, endereco, telefone, data_cadastro, token) FROM stdin;
    public               postgres    false    224   �I       �           0    0    estoque_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.estoque_id_seq', 2, true);
          public               postgres    false    217            �           0    0    fornecedor_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.fornecedor_id_seq', 1, true);
          public               postgres    false    219            �           0    0    produto_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.produto_id_seq', 2, true);
          public               postgres    false    221            �           0    0    usuario_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.usuario_id_seq', 74, true);
          public               postgres    false    223            �           2606    32836    estoque estoque_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.estoque DROP CONSTRAINT estoque_pkey;
       public                 postgres    false    218            �           2606    49458    fornecedor fornecedor_cnpj_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key UNIQUE (cnpj);
 H   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key;
       public                 postgres    false    220            �           2606    49460    fornecedor fornecedor_cnpj_key1 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key1 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key1;
       public                 postgres    false    220            �           2606    49478     fornecedor fornecedor_cnpj_key10 
   CONSTRAINT     [   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key10 UNIQUE (cnpj);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key10;
       public                 postgres    false    220            �           2606    49480     fornecedor fornecedor_cnpj_key11 
   CONSTRAINT     [   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key11 UNIQUE (cnpj);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key11;
       public                 postgres    false    220            �           2606    49462    fornecedor fornecedor_cnpj_key2 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key2 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key2;
       public                 postgres    false    220            �           2606    49464    fornecedor fornecedor_cnpj_key3 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key3 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key3;
       public                 postgres    false    220            �           2606    49466    fornecedor fornecedor_cnpj_key4 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key4 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key4;
       public                 postgres    false    220            �           2606    49468    fornecedor fornecedor_cnpj_key5 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key5 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key5;
       public                 postgres    false    220            �           2606    49470    fornecedor fornecedor_cnpj_key6 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key6 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key6;
       public                 postgres    false    220            �           2606    49472    fornecedor fornecedor_cnpj_key7 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key7 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key7;
       public                 postgres    false    220            �           2606    49474    fornecedor fornecedor_cnpj_key8 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key8 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key8;
       public                 postgres    false    220            �           2606    49476    fornecedor fornecedor_cnpj_key9 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key9 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key9;
       public                 postgres    false    220            �           2606    49484    fornecedor fornecedor_email_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key UNIQUE (email);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key;
       public                 postgres    false    220            �           2606    49486     fornecedor fornecedor_email_key1 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key1 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key1;
       public                 postgres    false    220            �           2606    49504 !   fornecedor fornecedor_email_key10 
   CONSTRAINT     ]   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key10 UNIQUE (email);
 K   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key10;
       public                 postgres    false    220                        2606    49506 !   fornecedor fornecedor_email_key11 
   CONSTRAINT     ]   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key11 UNIQUE (email);
 K   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key11;
       public                 postgres    false    220                       2606    49488     fornecedor fornecedor_email_key2 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key2 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key2;
       public                 postgres    false    220                       2606    49490     fornecedor fornecedor_email_key3 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key3 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key3;
       public                 postgres    false    220                       2606    49492     fornecedor fornecedor_email_key4 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key4 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key4;
       public                 postgres    false    220                       2606    49494     fornecedor fornecedor_email_key5 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key5 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key5;
       public                 postgres    false    220            
           2606    49496     fornecedor fornecedor_email_key6 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key6 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key6;
       public                 postgres    false    220                       2606    49498     fornecedor fornecedor_email_key7 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key7 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key7;
       public                 postgres    false    220                       2606    49500     fornecedor fornecedor_email_key8 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key8 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key8;
       public                 postgres    false    220                       2606    49502     fornecedor fornecedor_email_key9 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key9 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key9;
       public                 postgres    false    220                       2606    32845    fornecedor fornecedor_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_pkey;
       public                 postgres    false    220                       2606    32858    produto produto_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public                 postgres    false    222                       2606    49510    usuario usuario_cpf_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key UNIQUE (cpf);
 A   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_cpf_key;
       public                 postgres    false    224                       2606    49512    usuario usuario_cpf_key1 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key1 UNIQUE (cpf);
 B   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_cpf_key1;
       public                 postgres    false    224                       2606    49516    usuario usuario_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key;
       public                 postgres    false    224                       2606    49518    usuario usuario_email_key1 
   CONSTRAINT     V   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key1 UNIQUE (email);
 D   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key1;
       public                 postgres    false    224                       2606    49449    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public                 postgres    false    224            �   A   x�M���0�7T�@��D-鿎8�H��		!n,Cs1y��[)��u��a9N~�qU}��i      �   q   x�=�;�0�z}�����z�|*�ti��h�`���*4�x
��=\��ېh����|�;_gz����Y��ۭ�Х-|�ϑ�ҁ�Dt$�h��(FcL.j���1_w�0      �   V   x�3�(�O)-�W�Eb*��*����r�椖��e&�s�pY@������3��^!%_� IT� S�~��=... ��$�      �   �   x���N�0 �sy�8���?����-8d[��K[�d�X���ro�S/������ �K��fW�p�W�a�?���¨����U�ݼ�����(f:�?߾i�MJ�`�b%�S���u8�Uݟ�U=1~t��ޔs��
5����C��ŭ����aJ%&8�~����w~�͛��� !��,rĀ�2�$��R�%���pR� �&Zg�P�,��X k�FK�$Q��tH     