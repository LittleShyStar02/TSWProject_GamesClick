<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
	<%@include file="head.jsp" %>
	<style>
        fieldset {
          display: none;
        }

        .show_fieldset {
          display: inline;
        }
	</style>
	<script>
        function showFieldset(fieldsetToShow, fieldsetToHide) {
          fieldsetToShow = document.getElementById(fieldsetToShow);
          fieldsetToHide = document.getElementById(fieldsetToHide);
          var userInput = fieldsetToShow.querySelector("input");
          fieldsetToShow.classList.add("show_fieldset");
          fieldsetToHide.classList.remove("show_fieldset");

          setTimeout(function () {
            userInput.focus();
          }, 500);
        }
      </script>
</head>
<body>
	<%@include file="header.jsp" %>
	<div class="first-container center">

        <button onclick="showFieldset('fieldset_catalogo', 'fieldset_ordini')">Gestione catalogo</button>
        <button onclick="showFieldset('fieldset_ordini', 'fieldset_catalogo')">Gestione ordini</button>
        
        <br>
        <br>

        <!--sezione operazioni catalogo -->


        <form style="align-items: center" id="catalogo" name="catalogo" method="post" action="noaction.html">
          <fieldset id="fieldset_catalogo">
            <legend>Gestione catalogo</legend>
            <br>
            <p>
              <select name="operazione">
                <option value="add" selected="selected">Aggiungi articolo </option>
                <option value="edit">Modifica articolo </option>
                <option value="delete">Elimina articolo </option>
                </select>
                </p>
                <br>
                <p>
                  <label for="id_gioco">Id gioco:</label>
                  <input type="text" id="id_gioco" placeholder="Id gioco">
                </p>
				<br>
                <p>
                  <label for="nome">Nome:</label>
                  <input type="text" id="nome" placeholder="Nome">
                </p>

                <br>
                <p>
                  <label for="Descrizione">Descrizione:</label>
                  </p>
                  <textarea id="Descrizione" name="Descrizione" rows="4" cols="40"></textarea>
                <br>
				<br>
            <p>
              <label for="Prezzo">Prezzo:</label>
              <input type="number" id="Prezzo">
            </p>
			<br>
            <p>
              <label for="data">Data rilascio:</label>
              <input type="date" id="data">
            </p>
            <br>
            <p>
              <label for="eta">Età minima:</label>
              <input type="number" id="eta">
            </p>
			<br>
            <p>
              <button name="button" id="button">Conferma</button>
            </p>
            <br>
          </fieldset>




          <!--sezione ordini-->

          <fieldset id="fieldset_ordini">
            <legend>Gestione ordini</legend>
            <br>
            <p>
              <label for="user">Visualizza ordini per email:</label>
              <input type="text" id="user" placeholder="Inserisci la email dell'utente">
            </p>
            <br>
            <p>
              <label for="da">Visualizza ordini effettuati dal:</label>
              <input type="date" name="da" id="da">
            </p>
            <br>
            <p>
              <label for="a">fino al:</label>
              <input type="date" name="a" id="a">
            </p>
            <br>
            <p>
              <button name="button" id="button">Conferma</button>
            </p>
            <br>
          </fieldset>
        </form>

      </div>


	<%@include file="footer.jsp" %>
</body>
</html>