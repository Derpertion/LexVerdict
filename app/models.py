from typing import List, Optional
from sqlalchemy import Date, DateTime, Enum, ForeignKeyConstraint, Index, String, Text, ForeignKey
from sqlalchemy.dialects.mysql import INTEGER,TINYINT
from sqlalchemy.orm import Mapped, mapped_column, relationship
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
import datetime

db = SQLAlchemy()

class Person(db.Model):
    __tablename__ = 'person'

    PERSON_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    Last_name: Mapped[str] = mapped_column(String(100))
    First_name: Mapped[str] = mapped_column(String(100))
    Suffix: Mapped[str] = mapped_column(Enum('Jr.', 'Sr.', 'II', 'III', 'IV'))
    Sex: Mapped[str] = mapped_column(Enum('Male', 'Female'))
    Middle_name: Mapped[Optional[str]] = mapped_column(String(100))
    Date_of_Birth: Mapped[Optional[datetime.date]] = mapped_column(Date)

    address: Mapped[List['Address']] = relationship('Address', back_populates='person')
    prosecutor: Mapped[List['Prosecutor']] = relationship('Prosecutor', back_populates='person')
    user: Mapped[List['User']] = relationship('User', back_populates='person')
    involved_party: Mapped[List['InvolvedParty']] = relationship('InvolvedParty', back_populates='person')


class Address(db.Model):
    __tablename__ = 'address'
    __table_args__ = (
        ForeignKeyConstraint(['PERSON_ID'], ['person.PERSON_ID'], name='address_ibfk_1'),
        Index('PERSON_ID', 'PERSON_ID')
    )

    Address_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    Street: Mapped[Optional[str]] = mapped_column(String(255))
    Barangay: Mapped[Optional[str]] = mapped_column(String(100))
    Municipality: Mapped[Optional[str]] = mapped_column(String(100))
    Province: Mapped[Optional[str]] = mapped_column(String(100))
    Region: Mapped[Optional[str]] = mapped_column(String(100))
    PERSON_ID: Mapped[Optional[int]] = mapped_column(INTEGER(11))

    person: Mapped[Optional['Person']] = relationship('Person', back_populates='address')


class Prosecutor(db.Model):
    __tablename__ = 'prosecutor'
    __table_args__ = (
        ForeignKeyConstraint(['PERSON_ID'], ['person.PERSON_ID'], name='prosecutor_ibfk_1'),
        Index('PERSON_ID', 'PERSON_ID')
    )

    PROSECUTOR_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    PERSON_ID: Mapped[Optional[int]] = mapped_column(INTEGER(11))
    Licens_No: Mapped[Optional[str]] = mapped_column(String(100))
    Office_No: Mapped[Optional[str]] = mapped_column(String(100))

    person: Mapped[Optional['Person']] = relationship('Person', back_populates='prosecutor')
    subpoena: Mapped[List['Subpoena']] = relationship('Subpoena', back_populates='prosecutor')


class User(UserMixin, db.Model):
    __tablename__ = 'user'
    __table_args__ = (
        ForeignKeyConstraint(['PERSON_ID'], ['person.PERSON_ID'], name='user_ibfk_1'),
        Index('PERSON_ID', 'PERSON_ID')
    )

    USER_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    PERSON_ID: Mapped[Optional[int]] = mapped_column(INTEGER(11))
    Role: Mapped[Optional[str]] = mapped_column(Enum('PS', 'Prosecutor', 'Secretary', 'superuser'))
    Archived: Mapped[int] = mapped_column(TINYINT(1), default=0)  

    person: Mapped[Optional['Person']] = relationship('Person', back_populates='user')
    log_table: Mapped[List['LogTable']] = relationship('LogTable', back_populates='user')
    password: Mapped[List['Password']] = relationship('Password', back_populates='user')
    username: Mapped[List['Username']] = relationship('Username', back_populates='user')

    def get_id(self):
        return str(self.USER_ID)
    
    @property
    def is_active(self):
        return self.Archived == 0



class LogTable(db.Model):
    __tablename__ = 'log_table'
    __table_args__ = (
        ForeignKeyConstraint(['USER_ID'], ['user.USER_ID'], name='log_table_ibfk_1'),
        Index('USER_ID', 'USER_ID')
    )

    LOG_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    USER_ID: Mapped[Optional[int]] = mapped_column(INTEGER(11))
    Action: Mapped[Optional[str]] = mapped_column(Text)
    Timestamp: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime)

    user: Mapped[Optional['User']] = relationship('User', back_populates='log_table')


class Password(db.Model):
    __tablename__ = 'password'
    __table_args__ = (
        ForeignKeyConstraint(['USER_ID'], ['user.USER_ID'], name='password_ibfk_1'),
        Index('USER_ID', 'USER_ID')
    )

    PASSWORD_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    Password: Mapped[Optional[str]] = mapped_column(String(255))
    USER_ID: Mapped[Optional[int]] = mapped_column(INTEGER(11))

    user: Mapped[Optional['User']] = relationship('User', back_populates='password')


class Subpoena(db.Model):
    __tablename__ = 'subpoena'
    __table_args__ = (
        ForeignKeyConstraint(['PROSECUTOR_ID'], ['prosecutor.PROSECUTOR_ID'], name='subpoena_ibfk_1'),
        Index('PROSECUTOR_ID', 'PROSECUTOR_ID')
    )

    Docket_Number: Mapped[str] = mapped_column(String(50), primary_key=True)
    Date_: Mapped[Optional[datetime.date]] = mapped_column('Date', Date)
    Hearing_Date_1: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime)
    Hearing_Date_2: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime)
    Police_Station: Mapped[Optional[str]] = mapped_column(String(255))
    PROSECUTOR_ID: Mapped[Optional[int]] = mapped_column(INTEGER(11))

    Status: Mapped[Optional[str]] = mapped_column(Enum('Pending', 'Approved', 'Denied'), default='Pending')

    prosecutor: Mapped[Optional['Prosecutor']] = relationship('Prosecutor', back_populates='subpoena')
    involved_party: Mapped[List['InvolvedParty']] = relationship('InvolvedParty', back_populates='subpoena')
    pin_code: Mapped[List['PinCode']] = relationship('PinCode', back_populates='subpoena')
    resolution: Mapped[List['Resolution']] = relationship('Resolution', back_populates='subpoena')
    offenses: Mapped[list["Offense"]] = relationship("Offense", secondary="subpoena_offense", back_populates="subpoenas")


class Username(db.Model):
    __tablename__ = 'username'
    __table_args__ = (
        ForeignKeyConstraint(['USER_ID'], ['user.USER_ID'], name='username_ibfk_1'),
        Index('USER_ID', 'USER_ID')
    )

    USERNAME_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    Username: Mapped[Optional[str]] = mapped_column(String(100))
    USER_ID: Mapped[Optional[int]] = mapped_column(INTEGER(11))

    user: Mapped[Optional['User']] = relationship('User', back_populates='username')


class InvolvedParty(db.Model):
    __tablename__ = 'involved_party'
    __table_args__ = (
        ForeignKeyConstraint(['Docket_Number'], ['subpoena.Docket_Number'], name='involved_party_ibfk_2'),
        ForeignKeyConstraint(['PERSON_ID'], ['person.PERSON_ID'], name='involved_party_ibfk_1'),
        Index('Docket_Number', 'Docket_Number')
    )

    PERSON_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    Docket_Number: Mapped[str] = mapped_column(String(50), primary_key=True)
    Role: Mapped[Optional[str]] = mapped_column(Enum('Complainant', 'Respondent'))

    subpoena: Mapped['Subpoena'] = relationship('Subpoena', back_populates='involved_party')
    person: Mapped['Person'] = relationship('Person', back_populates='involved_party')


class PinCode(db.Model):
    __tablename__ = 'pin_code'
    __table_args__ = (
        ForeignKeyConstraint(['Docket_Number'], ['subpoena.Docket_Number'], name='pin_code_ibfk_1'),
        Index('Docket_Number', 'Docket_Number')
    )

    PIN_CODE: Mapped[str] = mapped_column(String(10), primary_key=True)
    Docket_Number: Mapped[Optional[str]] = mapped_column(String(50))

    subpoena: Mapped[Optional['Subpoena']] = relationship('Subpoena', back_populates='pin_code')


class Resolution(db.Model):
    __tablename__ = 'resolution'
    __table_args__ = (
        ForeignKeyConstraint(['Docket_Number'], ['subpoena.Docket_Number'], name='resolution_ibfk_1'),
        Index('Docket_Number', 'Docket_Number')
    )

    RESOLUTION_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    Docket_Number: Mapped[Optional[str]] = mapped_column(String(50))
    Verdict: Mapped[Optional[str]] = mapped_column(
        Enum('For Filing', 'Dismissed', 'Pending'),
        nullable=True
    )
    Court: Mapped[Optional[str]] = mapped_column(String(255))
    Date_: Mapped[Optional[datetime.date]] = mapped_column('Date', Date)
    Status: Mapped[Optional[str]] = mapped_column(
        Enum('Pending', 'Approved', 'Denied'),
        default='Pending',
        nullable=True
    )

    subpoena: Mapped[Optional['Subpoena']] = relationship('Subpoena', back_populates='resolution')
    transmital_batch: Mapped[List['TransmitalBatch']] = relationship('TransmitalBatch', back_populates='resolution')



class TransmitalBatch(db.Model):
    __tablename__ = 'transmital_batch'
    __table_args__ = (
        ForeignKeyConstraint(['RESOLUTION_ID'], ['resolution.RESOLUTION_ID'], name='transmital_batch_ibfk_1'),
        Index('RESOLUTION_ID', 'RESOLUTION_ID')
    )

    TRANSMITAL_ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    RESOLUTION_ID: Mapped[Optional[int]] = mapped_column(INTEGER(11))
    Date_Generated: Mapped[Optional[datetime.date]] = mapped_column(Date)
    Generated_by: Mapped[Optional[str]] = mapped_column(String(255))

    resolution: Mapped[Optional['Resolution']] = relationship('Resolution', back_populates='transmital_batch')

class DenialComment(db.Model):
    __tablename__ = 'denial_comment'
    ID: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    Docket_Number: Mapped[str] = mapped_column(String(50), ForeignKey('subpoena.Docket_Number'))
    Type: Mapped[str] = mapped_column(Enum('Subpoena', 'Resolution'))
    Comment: Mapped[str] = mapped_column(Text)
    Created_By: Mapped[int] = mapped_column(INTEGER(11), ForeignKey('user.USER_ID'))
    Timestamp: Mapped[Optional[datetime.datetime]] = mapped_column(DateTime, default=datetime.datetime.utcnow)

    subpoena: Mapped[Optional['Subpoena']] = relationship('Subpoena')
    user: Mapped[Optional['User']] = relationship('User')

class Offense(db.Model):
    __tablename__ = 'offense'

    offense_id: Mapped[int] = mapped_column(INTEGER(11), primary_key=True, autoincrement=True)
    Name: Mapped[str] = mapped_column(String(255), nullable=False)
    Law_Reference: Mapped[Optional[str]] = mapped_column(String(255))

    # Relationship: back to Subpoena via link table
    subpoenas: Mapped[list["Subpoena"]] = relationship(
        "Subpoena",
        secondary="subpoena_offense",
        back_populates="offenses"
    )

class SubpoenaOffense(db.Model):
    __tablename__ = 'subpoena_offense'
    __table_args__ = (
        ForeignKeyConstraint(['Docket_Number'], ['subpoena.Docket_Number'], name='subpoena_offense_ibfk_1', ondelete="CASCADE", onupdate="CASCADE"),
        ForeignKeyConstraint(['offense_id'], ['offense.offense_id'], name='subpoena_offense_ibfk_2', ondelete="RESTRICT", onupdate="CASCADE"),
        Index('Docket_Number', 'Docket_Number')
    )

    Docket_Number: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)
    offense_id: Mapped[int] = mapped_column(INTEGER(11), primary_key=True)