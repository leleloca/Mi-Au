<%@page language="java" import="java.sql.*" %>

<%
    //cria variaveis e armazena as informações digitadas pelo usuário
    String vlogin = request.getParameter( "txtLogin" ) ;
    String vsenha = request.getParameter( "txtSenha" ) ;

    //variavel para acessar o banco de dados
    String database   = "miau" ;
    String enderecoBD = "jdbc:mysql://localhost:3306/" + database ;
    String usuarioBD  = "root" ;
    String senhaBD    = "" ;


    //Driver
    String driver = "com.mysql.jdbc.Driver" ;

    //Carregar o driver na memoria
    Class.forName( driver ) ;    

    //Cria uma variavel para conexao com o banco de dados
    Connection conexao;

    //Abrir a conexao com o banco
    conexao = DriverManager.getConnection( enderecoBD, usuarioBD , senhaBD ) ;

    //comando para consultar no banco
    String sql = "SELECT * FROM usuario WHERE email=? AND senha=?" ;

    //cria a variavel do tipo Statement
    PreparedStatement stm = conexao.prepareStatement( sql );

    stm.setString( 1 , vlogin ) ;    
    stm.setString( 2 , vsenha ) ;

    //cria a variavel do tipo ResultSet
    //para armazenar os dados que estão banco
    ResultSet dados  = stm.executeQuery() ;

    if( dados.next() ) {
        //LOGIN OK
        session.setAttribute("usuario" ,  dados.getString("nome") ) ;
        response.sendRedirect( "consulta2.jsp" ) ;
    }else{
        //LOGIN NÃO OK
        out.print("Login incorreto") ;
        out.print("<br><br>") ;
        out.print("<a href='login.html'>Login</a>") ;
    }

%>