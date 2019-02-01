# Full House

Please read the problem statement [here](https://docs.google.com/document/d/1NiLvnbmIVmiFco5iQuptvy5Om2c9DLp_ntOByDIdU6A/edit)

**Live Version:** [https://fullhouse-csc517.herokuapp.com/](https://fullhouse-csc517.herokuapp.com/)

## Usage

All the features in the problem statement have been implemented. Once you login as an **_Administrator/Reatlor/House Hunter_** you will be redirected to the home page of that user and all the activities you can perform are mentioned there.

It is easily navigatable and all the actions that you can perform are available via the links visible to you.

For additional assistance with performing various scenarios, please see the document that was included with the project submission on Expertiza. You may also access [this document](https://docs.google.com/document/d/1SZIWTZLD8a7CvwujwAuMHKFotZSU3B8CWrcgoj7kc_E/edit?usp=sharing)

### Administrator Credentials

- Email: admin@fullhouse.com
- Password: 123456789

## Caveats

- When a reply is posted to an **Inquiry** the **House Hunter** who posted the inquiry will get a mail. There are chances that this mail will be marked as **spam**, so please check the **SPAM** folder.

- A **Realtor** without a **Real Estate Company** will probably cause problems and the system will not be usable. Please select a company while signing up or do it **immediately** after sign up.

## Setup

- Tested on Ruby [2.4.4](https://www.ruby-lang.org/en/downloads/releases/)

- [Node.JS](https://nodejs.org/) is required

- Run `bundle install` to install the required gems

- Run `rake db:migrate` to setup the database

- Setup the seed data by running `rake db:seed`

- Start the application by running `rails server`

- You can visit the app at [http://localhost:3000](http://localhost:3000)

## Testing

- Run `bundle install` to install the required gems

- Run `rake db:migrate RAILS_ENV=test` to setup the test database

- Run `bundle exec rspec` to see the test reports
