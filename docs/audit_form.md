# Audit Form Response Format

## Example

`/api/v1/audit_forms/find?permit_name=BE-FB`:

```json
{
  "status": "success",
  "data": {
    "audit_form": {
      "permit_name": "BE-FB",
      "total_questions": 31,
      "questions": [
        {
          "question_text": "Name of Person Filling Out Survey (First & Last)",
          "max_characters": 50,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "1",
          "type": "text_box",
          "choices": [],
          "conditions": []
        },
        {
          "question_text": "Position of person filling out survey",
          "max_characters": 10,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "2",
          "type": "text_box",
          "choices": [],
          "conditions": []
        },
        {
          "question_text": "Name/position of person(s) authorized to purchase alcohol for the business",
          "max_characters": 50,
          "multiline": true,
          "source": null,
          "other": null,
          "question_id": "3",
          "type": "text_box",
          "choices": [],
          "conditions": []
        },
        {
          "question_text": "Is your permit posted where it can be seen by the public?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "4",
          "type": "radio",
          "choices": [
            {
              "id": 1,
              "picture_attachment": true,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 2,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Public Information Sign Posted",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "5",
          "type": "radio",
          "choices": [
            {
              "id": 3,
              "picture_attachment": true,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 4,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Weapons Sign Posted (Blue/Red/Both/None)",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "7",
          "type": "radio",
          "choices": [
            {
              "id": 7,
              "picture_attachment": true,
              "text": "Blue",
              "fields": []
            },
            {
              "id": 8,
              "picture_attachment": true,
              "text": "Red",
              "fields": []
            },
            {
              "id": 9,
              "picture_attachment": true,
              "text": "Both",
              "fields": []
            },
            {
              "id": 10,
              "picture_attachment": false,
              "text": "None",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Fetal Alcohol Sign Posted in Men's & Women's Restrooms",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "8",
          "type": "radio",
          "choices": [
            {
              "id": 11,
              "picture_attachment": true,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 12,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Human Trafficking Sign Posted",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "9",
          "type": "radio",
          "choices": [
            {
              "id": 13,
              "picture_attachment": true,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 14,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Do you have alcohol advertising on the outside of the business?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "11A",
          "type": "radio",
          "choices": [
            {
              "id": 17,
              "picture_attachment": true,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 18,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Does your business have a \"Happy Hour\"?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "11B",
          "type": "radio",
          "choices": [
            {
              "id": 19,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 20,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Does your business run a \"Reverse Happy Hour\"?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "11C",
          "type": "radio",
          "choices": [
            {
              "id": 21,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 22,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "List the vendors you purchase alcohol from",
          "max_characters": 0,
          "multiline": false,
          "source": "/api/v1/vendors/names",
          "other": 50,
          "question_id": "12",
          "type": "drop_down",
          "choices": [],
          "conditions": []
        },
        {
          "question_text": "Are you holding any product that is damaged?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "13A",
          "type": "radio",
          "choices": [
            {
              "id": 23,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 24,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": [
            {
              "condition_value": "No",
              "conditional_question_id": "14A"
            }
          ]
        },
        {
          "question_text": "What product are you holding and why?",
          "max_characters": 100,
          "multiline": true,
          "source": null,
          "other": null,
          "question_id": "13B",
          "type": "text_box",
          "choices": [],
          "conditions": []
        },
        {
          "question_text": "Is seller training required for all employees that sell/serve alcohol?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "14A",
          "type": "radio",
          "choices": [
            {
              "id": 25,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 26,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": [
            {
              "condition_value": "No",
              "conditional_question_id": "18"
            }
          ]
        },
        {
          "question_text": "If seller training is required for employees, do you have alcohol service policies?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "14B",
          "type": "radio",
          "choices": [
            {
              "id": 27,
              "picture_attachment": true,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 28,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Do you maintain food service at the location?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "18",
          "type": "radio",
          "choices": [
            {
              "id": 35,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 36,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Is there a permanent food service facility at the location?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "19",
          "type": "radio",
          "choices": [
            {
              "id": 37,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 38,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Is the designated food service area at the location run by a separate business entity from the permit?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "20A",
          "type": "radio",
          "choices": [
            {
              "id": 39,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 40,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": [
            {
              "condition_value": "No",
              "conditional_question_id": "21"
            }
          ]
        },
        {
          "question_text": "Does the separate business entity maintain food service records?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "20B",
          "type": "radio",
          "choices": [
            {
              "id": 41,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 42,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Do you have multiple entrees per meal period?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "21",
          "type": "radio",
          "choices": [
            {
              "id": 43,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 44,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Are food items completely prepared or assembled on the premise?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "22",
          "type": "radio",
          "choices": [
            {
              "id": 45,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 46,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Is prepared food to be consumed on the premise?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "23",
          "type": "radio",
          "choices": [
            {
              "id": 47,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 48,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Are prepackaged food items sold?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "24A",
          "type": "radio",
          "choices": [
            {
              "id": 49,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 50,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": [
            {
              "condition_value": "No",
              "conditional_question_id": "25A"
            }
          ]
        },
        {
          "question_text": "Are prepackaged food items from a non-commercial source?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "24B",
          "type": "radio",
          "choices": [
            {
              "id": 51,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 52,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Are hours of operation for food and alcohol service the same?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "25A",
          "type": "radio",
          "choices": [
            {
              "id": 53,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 54,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": [
            {
              "condition_value": "Yes",
              "conditional_question_id": "26A"
            }
          ]
        },
        {
          "question_text": "What are your hours of operations for both food and alcohol service?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "25B",
          "type": "radio",
          "choices": [
            {
              "id": 55,
              "picture_attachment": false,
              "text": "Monday - Friday",
              "fields": [
                {
                  "label": "Food",
                  "type": "time_range"
                },
                {
                  "label": "Alcohol",
                  "type": "time_range"
                }
              ]
            },
            {
              "id": 56,
              "picture_attachment": false,
              "text": "Sunday",
              "fields": [
                {
                  "label": "Food",
                  "type": "time_range"
                },
                {
                  "label": "Alcohol",
                  "type": "time_range"
                }
              ]
            }
          ],
          "conditions": []
        },
        {
          "question_text": "Have you had a Breach of the Peace at your establishment in the last year?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "26A",
          "type": "radio",
          "choices": [
            {
              "id": 57,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 58,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": [
            {
              "condition_value": "No",
              "conditional_question_id": "27"
            }
          ]
        },
        {
          "question_text": "Who did you report any of the Breaches of the Peace to?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "26B",
          "type": "drop_down",
          "choices": [
            {
              "id": 59,
              "picture_attachment": false,
              "text": "Local Law Enforcement",
              "fields": []
            },
            {
              "id": 60,
              "picture_attachment": false,
              "text": "TABC",
              "fields": []
            },
            {
              "id": 61,
              "picture_attachment": false,
              "text": "Neither",
              "fields": []
            },
            {
              "id": 62,
              "picture_attachment": false,
              "text": "Both",
              "fields": []
            }
          ],
          "conditions": [
            {
              "condition_value": "TABC",
              "conditional_question_id": "27"
            },
            {
              "condition_value": "Both",
              "conditional_question_id": "27"
            }
          ]
        },
        {
          "question_text": "What date did the Breach of Peace occur? Describe the incident.",
          "max_characters": 100,
          "multiline": true,
          "source": null,
          "other": null,
          "question_id": "26C",
          "type": "text_box",
          "choices": [],
          "conditions": []
        },
        {
          "question_text": "Have there been changes since your original or renewal applications that have not been reported to TABC?",
          "max_characters": 0,
          "multiline": false,
          "source": null,
          "other": null,
          "question_id": "27",
          "type": "radio",
          "choices": [
            {
              "id": 63,
              "picture_attachment": false,
              "text": "Yes",
              "fields": []
            },
            {
              "id": 64,
              "picture_attachment": false,
              "text": "No",
              "fields": []
            }
          ],
          "conditions": []
        }
      ]
    }
  }
}
```

## Explanation

### Audit Form

#### Attributes

* `permit_name` The name of the permit that the questions apply to.
* `total_questions` The total number of questions for this audit form.
* `questions` One or more [Question](#question) objects.

### Question

#### Attributes

##### General

* `question_id` The question number.
* `question_text` The question text.
* `type` The question type.
* `choices` Zero or more [Choice](#choice) objects.
* `conditions` Zero or more [Condition](#condition) objects.

##### Text Box

* `max_characters` The maximum number of characters the user can enter in a text
  box.
* `multiline` If true, then the text box will appear larger, and allow line
  breaks.

##### Drop-Down

* `source` A URI or path indicating where the choices for a drop-down can be
  found.
* `other` If positive, then indicates the maximum number of characters for a
  special "Other" text box to be used in conjunction with the drop-down menu.

#### Types

* `radio` A list of choices with a radio button next to each choice. The user
  can only select one choice.
* `text_box` A text box field for the user to enter textual data.
* `drop_down` A drop-down menu. The user can only select one choice.

### Choice

#### Attributes

* `id` A unique identifier for choice tracking.
* `picture_attachment` If true, then a picture is required to be included.
* `text` The choice text.
* `fields` Zero or more additional fields for extra user input related to the
  choice.

### Field

#### Attributes

* `label` The field text.
* `type` The field type.

#### Types

* `time_range` Two time selection boxes that allow specifying a time range;
  e.g., open-close times.

### Condition

#### Attributes

* `condition_value` The choice text that triggers this condition.
* `conditional_question_id` The question id to jump to, if this condition is
  triggered.
