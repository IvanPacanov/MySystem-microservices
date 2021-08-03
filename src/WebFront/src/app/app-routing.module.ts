import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { HomeComponent } from "./pages/home/home.component";
import { LoginRegistrationComponent } from "./pages/login-registration/login-registration.component";
import { LoginComponent } from "./pages/login-registration/login/login.component";

const routes: Routes = [
    
    {path: '', redirectTo: '/login$Register', pathMatch: 'full'},
    {path: 'login$Register', component: LoginRegistrationComponent},
    {path: 'HomePage', component: HomeComponent}
]

@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule{

}