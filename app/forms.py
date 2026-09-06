from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField, DateTimeField, DateField, FormField, FieldList, SelectField, TextAreaField, HiddenField, SelectMultipleField
from wtforms.validators import DataRequired, Optional, Length

class LoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Login')

class DocketForm(FlaskForm):
    docket = StringField('Docket', validators=[DataRequired()])
    pin = PasswordField('Pin', validators=[DataRequired()])
    submit = SubmitField('Login')

class PersonForm(FlaskForm):
    class Meta:
        csrf = False

    person_id = HiddenField()  
    address_id = HiddenField()  

    first_name = StringField('First Name', validators=[DataRequired()], render_kw={"pattern": "[A-Za-z\s]+"})
    middle_name = StringField('Middle Name', validators=[Optional()], render_kw={"pattern": "[A-Za-z\s]+"})
    last_name = StringField('Last Name', validators=[DataRequired()], render_kw={"pattern": "[A-Za-z\s]+"})
    suffix = SelectField('Suffix', choices=[('', 'Suffix'), ('Jr.', 'Jr.'), ('Sr.', 'Sr.'), ('II', 'II'), ('III', 'III'), ('IV', 'IV')], validators=[Optional()])
    birth_date = DateField('Date of Birth', validators=[Optional()])
    sex = SelectField('Sex', choices=[('', 'Select Sex'), ('Male', 'Male'), ('Female', 'Female')], validators=[DataRequired()])

    # Address fields
    street = StringField('Street', validators=[DataRequired()])
    barangay = StringField('Barangay', validators=[DataRequired()])
    municipality = StringField('Municipality', validators=[DataRequired()])
    province = StringField('Province', validators=[DataRequired()])
    region = StringField('Region', validators=[DataRequired()])


class SubpoenaForm(FlaskForm):
    docket_number = StringField('Docket Number', validators=[DataRequired()])
    crimes = SelectMultipleField("Crimes", coerce=int, validate_choice=False, validators=[DataRequired()])
    date = DateField('Date', validators=[DataRequired()])
    hearing_date_1 = DateTimeField('Hearing Date 1', format='%Y-%m-%dT%H:%M', validators=[DataRequired()])
    hearing_date_2 = DateTimeField('Hearing Date 2', format='%Y-%m-%dT%H:%M', validators=[DataRequired()])
    prosecutor_id = SelectField('Prosecutor', coerce=int, validators=[DataRequired()], render_kw={"style": "width: 90%;"})
    police_station = StringField('Police Station', validators=[DataRequired()])

    complainants = FieldList(FormField(PersonForm), min_entries=1)
    respondents = FieldList(FormField(PersonForm), min_entries=1)

class ResolutionForm(FlaskForm):
    docket_number = HiddenField()
    verdict = SelectField(
        'Verdict',
        choices=[('Pending', 'Pending'), ('For Filing', 'For Filing'), ('Dismissed', 'Dismissed')],
        validators=[DataRequired()]
    )
    court = StringField('Court', validators=[Optional()])
    verdict_date = HiddenField()
    comment = TextAreaField('Comment')
    submit = SubmitField('Submit Resolution')

class CreateUserForm(FlaskForm):
    first_name = StringField('First Name', validators=[DataRequired()], render_kw={"pattern": "[A-Za-z\s]+"})
    last_name = StringField('Last Name', validators=[DataRequired()], render_kw={"pattern": "[A-Za-z\s]+"})
    middle_name = StringField('Middle Name', validators=[Optional()], render_kw={"pattern": "[A-Za-z\s]+"})
    suffix = SelectField('Suffix', choices=[('', 'Suffix'), ('Jr.', 'Jr.'), ('Sr.', 'Sr.'), ('II', 'II'), ('III', 'III'), ('IV', 'IV')], validators=[Optional()], render_kw={"style": "width: 90%;"})
    birth_date = DateField('Birth Date', validators=[Optional()])
    sex = SelectField('Sex', choices=[('', 'Select Sex'), ('Male', 'Male'), ('Female', 'Female')], validators=[DataRequired()], render_kw={"style": "width: 90%;"})
    street = StringField('Street', validators=[Optional()])
    barangay = StringField('Barangay', validators=[Optional()])
    municipality = StringField('Municipality', validators=[Optional()])
    province = StringField('Province', validators=[Optional()])
    region = StringField('Region', validators=[Optional()])

    role = SelectField('Role', choices=[
        ('', 'Select Role'),
        ('Secretary', 'Secretary'),
        ('Prosecutor', 'Prosecutor'),
        ('PS', 'Process Server'),
        ('superuser', 'Super User')
    ], validators=[DataRequired()], render_kw={"style": "width: 95%;"})

    license_no = StringField('License Number') 
    office_no = StringField('Office Number') 

    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[Optional()])

    submit = SubmitField('Create User')

class OffenseForm(FlaskForm):
    offense_id = HiddenField("Offense ID")
    name = StringField("Crime Name", validators=[DataRequired()])
    law_reference = StringField("Law Reference", validators=[Optional()])

    add = SubmitField("Add")
    edit = SubmitField("Edit")
    delete = SubmitField("Delete")