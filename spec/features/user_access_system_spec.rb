require 'rails_helper'

feature 'Usuario visualiza homepage' do
    scenario 'sem estar logado' do
        #arrange

        #act
        visit root_path

        #assert
        expect(page).to have_button "Entrar"
        expect(page).not_to have_button "Sair"
        
    
    end

    xscenario 'sem estar logado e clica no botao entrar' do
        #arrange
        
        #act
        visit root_path
        click 'Entrar'

        #assert
        expect(page).to have_content "Password"
        expect(page).not_to have_button "Login"


    end

end
