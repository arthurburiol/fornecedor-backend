PGDMP  "                    }            sis_fornecedor    17.4    17.4 =               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    25346    sis_fornecedor    DATABASE     t   CREATE DATABASE sis_fornecedor WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'pt-BR';
    DROP DATABASE sis_fornecedor;
                     postgres    false            �            1259    25347    estoque    TABLE     �   CREATE TABLE public.estoque (
    id integer NOT NULL,
    produto_id integer NOT NULL,
    quantidade integer NOT NULL,
    data_atualizacao timestamp with time zone
);
    DROP TABLE public.estoque;
       public         heap r       postgres    false            �            1259    25350    estoque_id_seq    SEQUENCE     �   CREATE SEQUENCE public.estoque_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.estoque_id_seq;
       public               postgres    false    217                       0    0    estoque_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.estoque_id_seq OWNED BY public.estoque.id;
          public               postgres    false    218            �            1259    25351 
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
       public         heap r       postgres    false            �            1259    25356    fornecedor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fornecedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.fornecedor_id_seq;
       public               postgres    false    219                       0    0    fornecedor_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.fornecedor_id_seq OWNED BY public.fornecedor.id;
          public               postgres    false    220            �            1259    25357    produto    TABLE       CREATE TABLE public.produto (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    descricao text NOT NULL,
    categoria character varying(50) NOT NULL,
    valor_unitario numeric(10,2) NOT NULL,
    fornecedor_id integer NOT NULL,
    peso_unitario numeric(10,2)
);
    DROP TABLE public.produto;
       public         heap r       postgres    false            �            1259    25362    produto_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.produto_id_seq;
       public               postgres    false    221                       0    0    produto_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;
          public               postgres    false    222            �            1259    25441    produtos_estoque_baixo    VIEW     �  CREATE VIEW public.produtos_estoque_baixo AS
 SELECT p.id AS produto_id,
    p.nome AS nome_produto,
    f.nome AS nome_fornecedor,
    sum(e.quantidade) AS estoque_atual
   FROM ((public.produto p
     JOIN public.fornecedor f ON ((f.id = p.fornecedor_id)))
     JOIN public.estoque e ON ((e.produto_id = p.id)))
  GROUP BY p.id, p.nome, f.nome
 HAVING (sum(e.quantidade) < 10)
  ORDER BY (sum(e.quantidade));
 )   DROP VIEW public.produtos_estoque_baixo;
       public       v       postgres    false    221    217    217    219    219    221    221            �            1259    25363    usuario    TABLE     e  CREATE TABLE public.usuario (
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
       public         heap r       postgres    false            �            1259    25368    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public               postgres    false    223                       0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
          public               postgres    false    224            4           2604    25369 
   estoque id    DEFAULT     h   ALTER TABLE ONLY public.estoque ALTER COLUMN id SET DEFAULT nextval('public.estoque_id_seq'::regclass);
 9   ALTER TABLE public.estoque ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    218    217            5           2604    25370    fornecedor id    DEFAULT     n   ALTER TABLE ONLY public.fornecedor ALTER COLUMN id SET DEFAULT nextval('public.fornecedor_id_seq'::regclass);
 <   ALTER TABLE public.fornecedor ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219            6           2604    25371 
   produto id    DEFAULT     h   ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);
 9   ALTER TABLE public.produto ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            7           2604    25372 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223            
          0    25347    estoque 
   TABLE DATA           O   COPY public.estoque (id, produto_id, quantidade, data_atualizacao) FROM stdin;
    public               postgres    false    217   �J                 0    25351 
   fornecedor 
   TABLE DATA           ^   COPY public.fornecedor (id, cnpj, nome, email, endereco, telefone, data_cadastro) FROM stdin;
    public               postgres    false    219   K                 0    25357    produto 
   TABLE DATA           o   COPY public.produto (id, nome, descricao, categoria, valor_unitario, fornecedor_id, peso_unitario) FROM stdin;
    public               postgres    false    221   �K                 0    25363    usuario 
   TABLE DATA           h   COPY public.usuario (id, cpf, nome, email, senha, endereco, telefone, data_cadastro, token) FROM stdin;
    public               postgres    false    223   L                  0    0    estoque_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.estoque_id_seq', 3, true);
          public               postgres    false    218                       0    0    fornecedor_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.fornecedor_id_seq', 2, true);
          public               postgres    false    220                       0    0    produto_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.produto_id_seq', 3, true);
          public               postgres    false    222                       0    0    usuario_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.usuario_id_seq', 76, true);
          public               postgres    false    224            9           2606    25374    estoque estoque_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.estoque
    ADD CONSTRAINT estoque_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.estoque DROP CONSTRAINT estoque_pkey;
       public                 postgres    false    217            ;           2606    25376    fornecedor fornecedor_cnpj_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key UNIQUE (cnpj);
 H   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key;
       public                 postgres    false    219            =           2606    25378    fornecedor fornecedor_cnpj_key1 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key1 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key1;
       public                 postgres    false    219            ?           2606    25380     fornecedor fornecedor_cnpj_key10 
   CONSTRAINT     [   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key10 UNIQUE (cnpj);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key10;
       public                 postgres    false    219            A           2606    25382     fornecedor fornecedor_cnpj_key11 
   CONSTRAINT     [   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key11 UNIQUE (cnpj);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key11;
       public                 postgres    false    219            C           2606    25384    fornecedor fornecedor_cnpj_key2 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key2 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key2;
       public                 postgres    false    219            E           2606    25386    fornecedor fornecedor_cnpj_key3 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key3 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key3;
       public                 postgres    false    219            G           2606    25388    fornecedor fornecedor_cnpj_key4 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key4 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key4;
       public                 postgres    false    219            I           2606    25390    fornecedor fornecedor_cnpj_key5 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key5 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key5;
       public                 postgres    false    219            K           2606    25392    fornecedor fornecedor_cnpj_key6 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key6 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key6;
       public                 postgres    false    219            M           2606    25394    fornecedor fornecedor_cnpj_key7 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key7 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key7;
       public                 postgres    false    219            O           2606    25396    fornecedor fornecedor_cnpj_key8 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key8 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key8;
       public                 postgres    false    219            Q           2606    25398    fornecedor fornecedor_cnpj_key9 
   CONSTRAINT     Z   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_cnpj_key9 UNIQUE (cnpj);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_cnpj_key9;
       public                 postgres    false    219            S           2606    25400    fornecedor fornecedor_email_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key UNIQUE (email);
 I   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key;
       public                 postgres    false    219            U           2606    25402     fornecedor fornecedor_email_key1 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key1 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key1;
       public                 postgres    false    219            W           2606    25404 !   fornecedor fornecedor_email_key10 
   CONSTRAINT     ]   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key10 UNIQUE (email);
 K   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key10;
       public                 postgres    false    219            Y           2606    25406 !   fornecedor fornecedor_email_key11 
   CONSTRAINT     ]   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key11 UNIQUE (email);
 K   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key11;
       public                 postgres    false    219            [           2606    25408     fornecedor fornecedor_email_key2 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key2 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key2;
       public                 postgres    false    219            ]           2606    25410     fornecedor fornecedor_email_key3 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key3 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key3;
       public                 postgres    false    219            _           2606    25412     fornecedor fornecedor_email_key4 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key4 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key4;
       public                 postgres    false    219            a           2606    25414     fornecedor fornecedor_email_key5 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key5 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key5;
       public                 postgres    false    219            c           2606    25416     fornecedor fornecedor_email_key6 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key6 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key6;
       public                 postgres    false    219            e           2606    25418     fornecedor fornecedor_email_key7 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key7 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key7;
       public                 postgres    false    219            g           2606    25420     fornecedor fornecedor_email_key8 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key8 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key8;
       public                 postgres    false    219            i           2606    25422     fornecedor fornecedor_email_key9 
   CONSTRAINT     \   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_email_key9 UNIQUE (email);
 J   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_email_key9;
       public                 postgres    false    219            k           2606    25424    fornecedor fornecedor_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.fornecedor DROP CONSTRAINT fornecedor_pkey;
       public                 postgres    false    219            m           2606    25426    produto produto_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.produto DROP CONSTRAINT produto_pkey;
       public                 postgres    false    221            o           2606    25428    usuario usuario_cpf_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key UNIQUE (cpf);
 A   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_cpf_key;
       public                 postgres    false    223            q           2606    25430    usuario usuario_cpf_key1 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_cpf_key1 UNIQUE (cpf);
 B   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_cpf_key1;
       public                 postgres    false    223            s           2606    25432    usuario usuario_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key;
       public                 postgres    false    223            u           2606    25434    usuario usuario_email_key1 
   CONSTRAINT     V   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_email_key1 UNIQUE (email);
 D   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_email_key1;
       public                 postgres    false    223            w           2606    25436    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public                 postgres    false    223            
   N   x�=���0Dѳ]E�5^#\��A�����Td���i1�ڱ$�&���} Ǯ^m)Xq����ǰ}�$�����c	         q   x�=�;�0�z}�����z�|*�ti��h�`���*4�x
��=\��ېh����|�;_gz����Y��ۭ�Х-|�ϑ�ҁ�Dt$�h��(FcL.j���1_w�0         o   x�3�(�O)-�W�Eb*��*����r�椖��e&�s�pY@������3��^!%_� IT� S�~�vc΀ ���� �`���WL!4]1z\\\ ;�1�         �  x�eϽv�0��Y\���d>ɒe1�`ZL0v�iCN�v�`��)���An��C�.��n��2*����A�ȋp��^�RUF�e�k�\t]����O�<ZYsBcf��w���H.7�B}�Bo
�`��Y�ݞ��
�x`���-��bZ���4J�����Z]����L��w��|��k]6�=�s��� ���Lp1`��C��T�8�Q��sl� i�1NF8hM�� q]`��EfI��K��^��K��>��}D���ah-�5u�����/�������znWUu.헻�Su8���n�5�~����R^����A��,+o�?n�$����m�FX	1��hyNv���Re�:��G�������_�Ѕ�4�r"#�8a��5�v@R1�f�F�ߖ�L     